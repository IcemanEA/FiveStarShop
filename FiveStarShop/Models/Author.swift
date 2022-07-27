//
//  Author.swift
//  FiveStarShop
//
//  Created by Egor Ledkov on 27.07.2022.
//

struct Author {
    let firstName: String
    let lastName: String
    let post: String
    let nickname: String
    
    var name: String {
        "\(firstName) \(lastName)"
    }
    
    var link: String {
        "https://github.com/\(nickname)"
    }
    
    static func getAuthors() -> [Author] {
        [
            Author(firstName: "Егор",
                               lastName: "Ледков",
                               post: "Верстальщик конечного продукта и подгоняльщик отстающих",
                               nickname: "IcemanEA")
            , Author (firstName: "",
                      lastName: "",
                      post: "",
                      nickname: "")
            , Author (firstName: "",
                      lastName: "",
                      post: "",
                      nickname: "")
            , Author (firstName: "",
                      lastName: "",
                      post: "",
                      nickname: "")
            , Author (firstName: "",
                      lastName: "",
                      post: "",
                      nickname: "")
        ]
    }
}
