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
                   post: "TeamLead, Git, код ревью, раздел О нас, финальная вертска",
                   nickname: "IcemanEA")
            , Author(firstName: "Асанкул",
                     lastName: "Садыков",
                     post: "Model&DataStore manager, раздел каталог, продукт",
                     nickname: "asankul")
            , Author(firstName: "Дмитрий",
                     lastName: "Коваленко",
                     post: "раздел Заказы и форма логина",
                     nickname: "DmitryPsycho")
            , Author(firstName: "Дмитрий",
                     lastName: "Карих",
                     post: "раздел Корзина и детализация заказов",
                     nickname: "Dim0ndr")
        ]
    }
}
