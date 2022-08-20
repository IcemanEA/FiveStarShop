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
