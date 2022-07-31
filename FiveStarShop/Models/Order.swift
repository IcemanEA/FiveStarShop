//
//  Order.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 27/7/22.
//

import Foundation


struct Order {
    let id: Int
    let date: String
    let purchases: [Purchase]
}

extension Order {
    
    static func getOrder() -> Order {
        Order(
            id: 1,
            date: "24.06.2022",
            purchases: Purchase.getPurchases(DataStore.shared.products)
        )
    }
    
    static var testOrder: Order {
        Order(
            id: 1,
            date: "24.06.2022",
            purchases: Purchase.getPurchases(DataStore.shared.products)
        )
    }
    
}
