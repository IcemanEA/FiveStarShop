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
    
    private let users = User.getUsers()
    private var activeUser: User? = nil {
        didSet {
            if activeUser != nil {
                navigationItem.rightBarButtonItem?.title = activeUser?.name
            } else {
                navigationItem.rightBarButtonItem?.title = "Авторизация"
            }
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let user = activeUser else { return 0 }
        return user.orders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)
        guard let user = activeUser else { return cell }
        let order = user.orders[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = "Заказ №\(String(order.id))"
        content.secondaryText = order.date
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        if let loginVC = navigationVC.topViewController as? LoginViewController {
            loginVC.delegate = self
            loginVC.users = users
        }
        else if let userMenuVC = navigationVC.topViewController as? UserMenuViewController {
            userMenuVC.delegate = self
            userMenuVC.user = users.first
        }
        /* else if let indexPath = tableView.indexPathForSelectedRow {
         guard let orderDetailsVC = segue.destination as? OrderTableViewController else { return }
         */
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
