//
//  Cart.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 27/7/22.
//

import Foundation


struct Cart {
    
    let prodcuts: [Product]
    
    var countOfProducts: String {
        "\(prodcuts.count)"
    }
}
