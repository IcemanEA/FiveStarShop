//
//  Users.swift
//  FiveStarShop
//
//  Created by Psycho on 27.07.2022.
//

struct User {
    let name: String
    let userName: String
    let password: String
    let orders: [Order]
    
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
                        carts: [
                            Cart(product: DataStore.shared.products[0], count: 1),
                            Cart(product: DataStore.shared.products[1], count: 1)
                        ]
                    ),
                    Order(
                        id: 2,
                        date: "27.06.2022",
                        carts: [
                            Cart(product: DataStore.shared.products[2], count: 1),
                            Cart(product: DataStore.shared.products[3], count: 2)
                        ]
                    )
                ]
            )
        ]
    }
}

