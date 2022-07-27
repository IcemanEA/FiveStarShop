//
//  Product.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 27/7/22.
//

import Foundation

struct Product {
    
    let model: String
    let company: String
    let description: String
    let price: Int
    let article: String
    
    var name: String {
        "\(model) \(company)"
    }
}
