//
//  Order.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 27/7/22.
//

import Foundation


struct Order {
    let userId: String
    let id: Int
    let date: String
    let carts: [Cart]
}
