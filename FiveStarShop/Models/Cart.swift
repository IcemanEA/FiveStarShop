//
//  Cart.swift
//  FiveStarShop
//
//  Created by Psycho on 28.07.2022.
//

import Foundation


struct Cart {
    let product: Product
    let count: Int
    
    var totalPrice: Int {
        product.price * count
    }
    
    var rubleCurrency: String {
        "\(totalPrice) ₽"
    }
    
}
