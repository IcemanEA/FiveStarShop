//
//  Cart.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 27/7/22.
//

import Foundation


struct Purchase: Decodable, Equatable {
    var id: UUID? = nil
    var product: Product
    var count: Int
    var totalPrice: Int {
        (product.price ?? 0) * count
    }
    
    static func ==(lhs: Purchase, rhs: Purchase) -> Bool {
        return lhs.product.article == rhs.product.article
    }
}
