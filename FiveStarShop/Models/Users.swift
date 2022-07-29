//
//  Users.swift
//  FiveStarShop
//
//  Created by Psycho on 27.07.2022.
//

import Foundation
import Metal

struct Users {
    let name: String
    let userName: String
    let password: String
    let orders: [Order]
    
    static func getUser() -> Users {
        Users(
            name: "Alexey",
            userName: "Debash",
            password: "password",
            orders: [Order(
                id: 1,
                date: "24.06.2022",
                carts: [
                    Cart(product: DataStore.shared.products[0], count: 1),
                    Cart(product: DataStore.shared.products[1], count: 1)
                ]
            ),
                     Order(
                        id: 2,
                        date: "27.06.2022",
                        carts: [
                            Cart(product: DataStore.shared.products[0], count: 1),
                            Cart(product: DataStore.shared.products[1], count: 1)
                        ]
                     )
            ]
        )
    }
}

