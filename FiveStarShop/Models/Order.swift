//
//  Order.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 27/7/22.
//

import Foundation

struct Order: Decodable {
    var id: UUID? = nil
    let number: Int
    let date: String
    var purchases: [Purchase]
    
    init(value: [String: Any], purchases: [Purchase]) {
        id = UUID(uuidString: value["id"] as? String ?? "")
        number = value["number"] as? Int ?? 0
        date = value["date"] as? String ?? ""
        self.purchases = purchases
    }
    
    func getLocalizedDate() -> String {
        guard let date = try? Date(date, strategy: Date.ISO8601FormatStyle()) else { return "" }

        return date.formatted(date: .abbreviated, time: .omitted)
    }
    
    static func uploadToServer(
        for userID: UUID,
        with purchases: [Purchase],
        completion: @escaping(Result<Order, NetworkError>) -> Void)
    {
        let requestBody: [String: Any] = NetworkManager.shared.setupRequestBody(
            .addOrder,
            userID: userID,
            data: purchases
        )
        
        NetworkManager.shared.postRequest(
            with: requestBody,
            to: NetworkManager.shared.getLink(.addOrder)) { result in
                switch result {
                case .success(let data):
                    do {
                        let orderAny = try JSONSerialization.jsonObject(with: data)
                        guard let orderDictionary = orderAny as? [String: Any] else { return }
                        completion(.success(Order(value: orderDictionary, purchases: purchases)))
                    } catch {
                        print(error)
                        return
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    static func updateProductInformation(for orders: [Order]) -> [Order] {
        orders.map { order in
            var changedOrder = order
            
            changedOrder.purchases = order.purchases.map { purchase in
                var changedPurchase = purchase
                
                if let index = DataStore.shared.products.firstIndex(
                    where: { $0.id == changedPurchase.product.id  }
                ) {
                    changedPurchase.product = DataStore.shared.products[index]
                }
                
                return changedPurchase
            }
            
            return changedOrder
        }
    }
}
