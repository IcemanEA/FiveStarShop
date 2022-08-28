//
//  CoreDataMananger.swift
//  FiveStarShop
//
//  Created by Egor Ledkov on 26.08.2022.
//

import Foundation
import CoreData

enum CoreDataError: Error {
    case noData
    case noConnection
}

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    // MARK: - Core Data Stack
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FiveStarShop")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var viewContext: NSManagedObjectContext!
    
    private init() {
        viewContext = persistentContainer.viewContext
    }
        
    // MARK: - FetchData
    func fetchData<T: NSManagedObject>(_ type: T.Type, completion: (Result<[T], CoreDataError>) -> Void) {
        let fetchRequest = T.fetchRequest()

        do {
            let fetchResults = try viewContext.fetch(fetchRequest)
            guard let results = fetchResults as? [T] else {
                completion(.failure(.noData))
                return
            }
            completion(.success(results))
            return
        } catch {
            print(error.localizedDescription)
            completion(.failure(.noConnection))
        }
    }
            
    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - CRUD CDProduct
extension CoreDataManager {
    func create(_ product: Product, _ competion: ((CDProduct) -> Void)? = nil) {
        let productCD = CDProduct(context: viewContext)
        setCDProduct(productCD, from: product)
        if let competion = competion {
            competion(productCD)
        }
        saveContext()
    }
    
    func fetchProducts(_ completion: (Result<[Product], CoreDataError>) -> Void) {
        CoreDataManager.shared.fetchData(CDProduct.self) { result in
            switch result {
            case .success(let productsCD):
                let products = productsCD.map { self.getProduct(from: $0) }
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func update(_ product: Product, for productCD: CDProduct) {
        setCDProduct(productCD, from: product)
        saveContext()
    }

    func delete(_ productCD: CDProduct) {
        viewContext.delete(productCD)
        saveContext()
    }
}

// MARK: - ViewsModel
extension CoreDataManager {
    private func setCDProduct(_ productCD: CDProduct, from product: Product) {
        productCD.id = product.id
        productCD.price = Int64(product.price ?? 0)
        productCD.article = product.article
        productCD.company = product.company
        productCD.model = product.model
        productCD.descriptionCD = product.description
    }
    private func getProduct(from productCD: CDProduct) -> Product {
        return Product(
            id: productCD.id,
            article: productCD.article,
            company: productCD.company,
            model: productCD.model,
            description: productCD.descriptionCD,
            price: Int(productCD.price)
        )
    }
}
