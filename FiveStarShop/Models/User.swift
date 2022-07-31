//
//  User.swift
//  FiveStarShop
//
//  Created by Egor Ledkov on 28.07.2022.
//

import Foundation

struct User {
    
    let name: String
    let userName: String
    let password: String
    let orders: [Order]
    
}

extension User {
    
    static func getUsers() -> [User] {
        [
            User(
                name: "Alexey",
                userName: "123",
                password: "123",
                orders: [
                    Order(
                        id: 1,
                        date: "24.06.2022",
                        purchases: [
                            Purchase(product: DataStore.shared.products[0], count: 1),
                            Purchase(product: DataStore.shared.products[1], count: 1)
                        ]
                    ),
                    Order(
                        id: 2,
                        date: "27.06.2022",
                        purchases: [
                            Purchase(product: DataStore.shared.products[2], count: 1),
                            Purchase(product: DataStore.shared.products[3], count: 2)
                        ]
                    )
                ]
            )
        ]
    }
    
}
