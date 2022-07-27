//
//  Product.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 27/7/22.
//

import Foundation

struct Product {
    
    let name: String
    let description: String
    let price: String
    let count: String
    
}

extension Product {
    static func getProducts() -> [Product] {
        
        var products: [Product] = []
        
        let names = DataStore.shared.names
        let descriptions = DataStore.shared.description
        let prices = DataStore.shared.price
        let counts = DataStore.shared.count
        
        let iterationCount = min(
            names.count,
            descriptions.count,
            prices.count,
            counts.count
        )
        
        for index in 0..<iterationCount {
            let product = Product(
                name: names[index],
                description: descriptions[index],
                price: prices[index],
                count: counts[index]
            )
            products.append(product)
        }
        
        return products
    }
}
