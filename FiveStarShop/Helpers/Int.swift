//
//  Int.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 31/7/22.
//

import Foundation

extension Int {
    func toRubleCurrency(withMark markIs: Bool = true) -> String {
        let price = self.formatted(.number.grouping(.automatic)
                                   .locale(Locale(identifier: "ru_RU")))
        return markIs ? price + " ₽" : price
    }
}
