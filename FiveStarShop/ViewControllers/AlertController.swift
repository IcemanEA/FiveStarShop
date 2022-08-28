//
//  AlertController.swift
//  FiveStarShop
//
//  Created by Egor Ledkov on 28.08.2022.
//

import UIKit

extension UIAlertController {
    
    static func createAlert(withTitle title: String, andMessage message: String) -> UIAlertController {
        UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
        
    func action(buttonTitle title: String, completion: (() -> Void)? = nil) {
        let okAction = UIAlertAction(title: title, style: .default) { _ in
            guard let completion = completion else { return }
            completion()
        }
        
        addAction(okAction)
    }
}
