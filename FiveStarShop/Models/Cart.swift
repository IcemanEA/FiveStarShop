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
