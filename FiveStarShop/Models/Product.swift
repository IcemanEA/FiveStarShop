//
//  Product.swift
//  FiveStarShop
//
//  Created by Psycho on 28.07.2022.
//

struct Product {
    let article: String
    let company: String
    let model: String
    let description: String
    let price: Int
    
    var name: String {
        "\(model) \(company)"
    }
    
    var rubleCurrency: String {
        "\(price) ₽"
    }
}
