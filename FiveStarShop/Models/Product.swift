//
//  Product.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 27/7/22.
//

import Foundation

struct Product: Decodable {
    let article: String
    let company: String
    let model: String
    let description: String
    let price: Int
    
    var name: String {
        "\(model) \(company)"
    }
}
