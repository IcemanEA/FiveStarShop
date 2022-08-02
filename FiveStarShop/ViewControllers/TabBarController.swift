//
//  TabBarController.swift
//  FiveStarShop
//
//  Created by Egor Ledkov on 01.08.2022.
//

import UIKit

protocol TabBarControllerDelegate {
    func openCart()
}

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        guard let viewControllers = viewControllers else { return }
        
        viewControllers.forEach { viewController in
            guard let navigatorVC = viewController as? UINavigationController else { return }
            
            if let catalogVC = navigatorVC.topViewController as? CatalogTableViewController {
                catalogVC.delegate = self
            } else if let ordersVC = navigatorVC.topViewController as? OrderListViewController {
                ordersVC.delegate = self
            }
        }
    }

}

// MARK: - TabBarControllerDelegate
extension TabBarController: TabBarControllerDelegate {
    func openCart() {
        var cartViewIndex = 0
        guard let viewControllers = viewControllers else { return }
        
        for (index, vc) in viewControllers.enumerated() {
            guard let navigatorVC = vc as? UINavigationController else { return }
                        
            if let _ = navigatorVC.topViewController as? PurchaseTableViewController {
                cartViewIndex = index
            }
        }
     
        selectedIndex = cartViewIndex
    }
}
