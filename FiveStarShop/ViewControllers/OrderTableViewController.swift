//
//  OrderTableViewController.swift
//  FiveStarShop
//
//  Created by Psycho on 27.07.2022.
//

import UIKit

protocol LoginViewControllerDelegate {
    func setUser(_ name: String)
}

class OrderTableViewController: UITableViewController {
    
    @IBOutlet var authorizeBtn: UIBarButtonItem!
    @IBOutlet var userBtn: UIBarButtonItem!
    
    private let user = Users.getUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.orders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)
        let order = user.orders[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = "Заказ \(String(order.id))"
        content.secondaryText = order.date
        cell.contentConfiguration = content
        cell.isHidden = false
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        if let loginVC = navigationVC.topViewController as? LoginViewController {
            loginVC.delegate = self
            loginVC.user = user
        }
        else if let userMenuVC = navigationVC.topViewController as? UserMenuViewController {
            userMenuVC.user = user
        }
    }
}

extension OrderTableViewController: LoginViewControllerDelegate {
    func setUser(_ name: String) {
        self.navigationItem.rightBarButtonItem = nil
        userBtn.title = name
    }
}

