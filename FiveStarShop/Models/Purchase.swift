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
