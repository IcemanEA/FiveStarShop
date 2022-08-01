//
//  TabBarController.swift
//  FiveStarShop
//
//  Created by Egor Ledkov on 01.08.2022.
//

import UIKit

protocol TabBarControllerDelegate {
    func setPurchasesInCart (_ purchases: [Purchase], andOpenIt: Bool)
}

class TabBarController: UITabBarController {

    var purchases: [Purchase] = []
    
    override func viewDidLoad() {
        guard let viewControllers = viewControllers else { return }
        
        viewControllers.forEach { viewController in
            guard let navigatorVC = viewController as? UINavigationController else { return }
            let openVC = navigatorVC.topViewController
            
            if let catalogVC = openVC as? CatalogTableViewController {
                catalogVC.delegate = self
                //                catalogVC.purchases = purchases
            } else if let purchaseVC = openVC as? PurchaseTableViewController {
                //                purchaseVC.delegate = self
                purchaseVC.purchases = purchases
            }
        }
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        guard let viewControllers = viewControllers else { return }
//        
//        viewControllers.forEach { viewController in
//            guard let navigatorVC = viewController as? UINavigationController else { return }
//            let openVC = navigatorVC.topViewController
//            
//            if let purchaseVC = openVC as? PurchaseTableViewController {
//                purchaseVC.purchases = purchases
//            }
//        }
        
    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let viewControllers = viewControllers else { return }
//
//        viewControllers.forEach { viewController in
//            guard let navigatorVC = viewController as? UINavigationController else { return }
//            let openVC = navigatorVC.topViewController
//
//            if let purchaseVC = openVC as? PurchaseTableViewController {
//                purchaseVC.purchases = purchases
//            }
//        }
//    }
}

// MARK: - TabBarControllerDelegate
extension TabBarController: TabBarControllerDelegate {
    func setPurchasesInCart(_ purchases: [Purchase], andOpenIt: Bool) {
        self.purchases = purchases
        
        var cartViewIndex = 0
        guard let viewControllers = viewControllers else { return }
        
        for (index, vc) in viewControllers.enumerated() {
            guard let navigatorVC = vc as? UINavigationController else { return }
                        
            if let purchaseVC = navigatorVC.topViewController as? PurchaseTableViewController {
                purchaseVC.purchases = purchases
                cartViewIndex = index
            }
        }
     
        if andOpenIt { selectedIndex = cartViewIndex }
    }
}
