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
        "\(price) ₽"
    }
    
    static func ==(lhs: Cart, rhs: Cart) -> Bool {
        return lhs.product.article == rhs.product.article
    }
}
