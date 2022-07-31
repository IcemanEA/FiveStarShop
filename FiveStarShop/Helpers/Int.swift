//
//  Int.swift
//  FiveStarShop
//
//  Created by Dimondr on 29.07.2022.
//

import Foundation

extension Int {
    func toRubleCurrency(withMark markIs: Bool = true) -> String {
        let price = self.formatted(.number.grouping(.automatic)
                                   .locale(Locale(identifier: "ru_RU")))
        return markIs ? price + " ₽" : price
    }
}

