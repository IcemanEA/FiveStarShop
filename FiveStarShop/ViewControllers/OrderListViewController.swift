//
//  OrderTableViewController.swift
//  FiveStarShop
//
//  Created by Psycho on 27.07.2022.
//

import UIKit

protocol LoginViewControllerDelegate {
    func setUser(_ user: User)
    
    func logOutUser()
}

class OrderListViewController: UITableViewController {
    
    var delegate: TabBarControllerDelegate!
    var activeUser: User? = nil {
        didSet {
            navigationItem.rightBarButtonItem?.title = activeUser?.name ?? "Авторизация"
            tableView.reloadData()
        }
    }
    
    private var orders: [Order] = []
    
    private var transitToCartIs = false
    
    // MARK: - Override methods
    
    override func viewWillAppear(_ animated: Bool) {
        if transitToCartIs {
            transitToCartIs = false
            delegate.openTab(with: .purchases)
        }
    }
        
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)
        let order = orders[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = "Заказ №\(String(order.id))"
        content.secondaryText = order.date
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func addOrderToActiveUser(_ order: Order) {
        orders.append(order)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let orderVC = segue.destination as? OrderTableViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                orderVC.order = orders[indexPath.row]
            }
        } else if let navigationVC = segue.destination as? UINavigationController {
            if let loginVC = navigationVC.topViewController as? LoginViewController {
                loginVC.delegate = self
            } else if let userMenuVC = navigationVC.topViewController as? UserMenuViewController {
                guard let user = activeUser else { return }
                userMenuVC.delegate = self
                userMenuVC.user = user
            }
        }
    }
    
    @IBAction func unwindToOrders(_ unwindSegue: UIStoryboardSegue) {
        transitToCartIs = true
    }
    
    // MARK: - Authorize button setup
    
    @IBAction func authorizeBtnPressed(_ sender: Any) {
        if activeUser == nil {
            performSegue(withIdentifier: "login", sender: nil)
        } else {
            performSegue(withIdentifier: "userMenu", sender: nil)
        }
    }
}

// MARK: - User login/logout logic setup

extension OrderListViewController: LoginViewControllerDelegate {
    func setUser(_ user: User) {
        activeUser = user
    }
    
    func logOutUser() {
        activeUser = nil
    }
}
