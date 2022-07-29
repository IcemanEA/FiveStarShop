//
//  Cart.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 27/7/22.
//
import Foundation


struct Cart: Equatable {
    let product: Product
    var count: Int
    
    var totalPrice: Int {
        product.price * count
    }
    
    var rubleCurrency: String {
        totalPrice.formatted(
            .number.grouping(.automatic)
            .locale(
                Locale(identifier: "ru_RU")
            )
        ) + "₽"
    }
    
    static func ==(lhs: Cart, rhs: Cart) -> Bool {
        return lhs.product.article == rhs.product.article
    }
    
}

// если кто-то таки запилит модель заказов - это можно удалить:
extension Cart {
    
    static func getCartGoods(_ products: [Product]) -> [Cart] {
        var goods: [Cart] = []
        
        let products = products.shuffled().prefix(Int.random(in: 1...products.count))
        
        for product in products {
            goods.append(
                Cart(
                    product: product,
                    count: Int.random(in: 1...3)
                )
            )
        }
        return goods
    }
    
}
