//
//  DataStore.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 27/7/22.
//

import Foundation

class DataStore {
    
    static let shared = DataStore()
    
    var cart: [Purchase] = []
    
    var products: [Product] = []
    
    private init() {}
}
