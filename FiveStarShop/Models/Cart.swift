//
//  Cart.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 27/7/22.
//

import Foundation


struct Cart {
    let produсt: Product
    let count: Int
    var totalPrice: Int {
        produсt.price * count
    }
    var rubleCurrency: String {
        "\(price) ₽"
    }
}
