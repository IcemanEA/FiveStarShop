//
//  Users.swift
//  FiveStarShop
//
//  Created by Psycho on 27.07.2022.
//

import Foundation

struct User: Codable {
    let id: UUID
    let name: String
    let userName: String
    let password: String?
}

