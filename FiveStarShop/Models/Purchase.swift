//
//  Cart.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 27/7/22.
//
import Foundation


struct Purchase: Equatable {
    let product: Product
    var count: Int
    
    var totalPrice: Int {
        product.price * count
    }
    
    static func ==(lhs: Purchase, rhs: Purchase) -> Bool {
        return lhs.product.article == rhs.product.article
    }
    
}

// если кто-то таки запилит модель заказов - это можно удалить:
extension Purchase {
    
    static func getPurchases(_ products: [Product]) -> [Purchase] {
        var purchases: [Purchase] = []
        
        let products = products.shuffled().prefix(Int.random(in: 1...products.count))
        
        for product in products {
            purchases.append(
                Purchase(
                    product: product,
                    count: Int.random(in: 1...3)
                )
            )
        }
        return purchases
    }
    
}
