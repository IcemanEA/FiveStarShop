//
//  Cart.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 27/7/22.
//

import Foundation


struct Cart {
    let product: Product
    var count: Int
    var totalPrice: Int {
        product.price * count
    }
    var rubleCurrency: String {
        "\(price) ₽"
    }
}

extension Cart {
    static func getGoods(_ products: [Product]) -> [Cart] {
        var goods: [Cart] = []
        let products = products.shuffled().prefix(5)
        
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
