//
//  TabBarController.swift
//  FiveStarShop
//
//  Created by Egor Ledkov on 01.08.2022.
//

import UIKit

protocol TabBarControllerDelegate {
    func openTab(with tabViewController: TabViewController)
}

class TabBarController: UITabBarController {
    
    private var user: User? = nil {
        didSet {
            setActivesUser()
        }
    }
    
    override func viewDidLoad() {
        guard let viewControllers = viewControllers else { return }
        
        fetchUser()
        
        viewControllers.forEach { viewController in
            guard let navigatorVC = viewController as? UINavigationController else { return }
            
            if let catalogVC = navigatorVC.topViewController as? CatalogTableViewController {
                catalogVC.delegate = self
            } else if let ordersVC = navigatorVC.topViewController as? OrderListViewController {
                ordersVC.delegate = self
            } else if let cartVC = navigatorVC.topViewController as? PurchaseTableViewController {
                cartVC.delegate = self
            }
        }
    }
    
    private func setActivesUser() {
        guard let viewControllers = viewControllers else { return }
        
        viewControllers.forEach { viewController in
            guard let navigatorVC = viewController as? UINavigationController else { return }
            
            if let ordersVC = navigatorVC.topViewController as? OrderListViewController {
                ordersVC.activeUser = user
            }
        }
    }
}

// MARK: - NetWorking
extension TabBarController {
    private func fetchUser() {
        guard let userID = StorageManager.shared.fetchUserID() else { return }
        let link = NetworkManager.shared.getUserLink(for: userID.uuidString, .backslash)
        
        NetworkManager.shared.fetch(User.self, from: link) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - TabBarControllerDelegate
extension TabBarController: TabBarControllerDelegate {
    
    func openTab(with tabViewController: TabViewController) {
        var cartViewIndex = 0
        guard let viewControllers = viewControllers else { return }
        
        for (index, vc) in viewControllers.enumerated() {
            guard let navigatorVC = vc as? UINavigationController else { return }
                 
            switch tabViewController {
            case .purchases:
                if let _ = navigatorVC.topViewController as? PurchaseTableViewController {
                    cartViewIndex = index
                }
            case .orders:
                if let _ = navigatorVC.topViewController as? OrderListViewController {
                    cartViewIndex = index
                }
            }
        }
     
        selectedIndex = cartViewIndex
    }
}

enum TabViewController {
    case purchases
    case orders
}
