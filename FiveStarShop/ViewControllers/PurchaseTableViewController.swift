//
//  PurchaseTableViewController.swift
//  FiveStarShop
//
//  Created by Dimondr on 27.07.2022.
//

import UIKit

protocol PurchaseViewCellDelegate {
    func calculateTotalSum(with cart: Purchase)
    func deleteFromCart(_ cart: Purchase)
}

class PurchaseTableViewController: UIViewController {
    // MARK: - IBOutlet and public properties
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var orderTextStack: UIStackView!
    @IBOutlet var totalSumLabel: UILabel!
    @IBOutlet var cartInButton: UIButton!
    
    var delegate: TabBarControllerDelegate!
    var purchases: [Purchase]! {
        didSet {
            navigationItem.title = "Корзина (\(purchases.count))"
        }
    }
    
    // MARK: - private properties
    
    private var clearBarButtonItem: UIBarButtonItem!
    private var totalSum = 0 {
        didSet {
            totalSumLabel.text = totalSum.toRubleCurrency()
        }
    }
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartInButton.layer.cornerRadius = 15
        clearBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"),
                                             style: .done,
                                             target: self,
                                             action: #selector(clearCartWithAlert))
        
        navigationItem.rightBarButtonItem = clearBarButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        purchases = DataStore.shared.cart
        
        tableView.reloadData()
        clearIfCartIsEmpty()
        getTotalCartSum()
    }
    
    // MARK: - IBActions
    
    @IBAction func cartInButtonPressed() {
        var activeUser: User?
        var ordersViewController: OrderListViewController?
        
        guard let viewControllers = tabBarController?.viewControllers else { return }
        viewControllers.forEach { viewController in
            guard let navigatorVC = viewController as? UINavigationController else { return }
            
            if let ordersVC = navigatorVC.topViewController as? OrderListViewController {
                activeUser = ordersVC.activeUser
                ordersViewController = ordersVC
            }
        }
        
        if let user = activeUser {
            newOrder(for: user, on: ordersViewController)
        } else {
            authorize(on: ordersViewController)
        }
    }
    
    // MARK: - Private methods    
    private func newOrder(for user: User, on viewController: OrderListViewController?) {
        Order.uploadToServer(for: user.id, with: purchases) { [weak self] result in
            switch result {
            case .success(let order):
                DispatchQueue.main.async {
                    if let ordersVC = viewController {
                        ordersVC.addOrderToActiveUser(order)
                    }
                    self?.showNewOrderAlert()
                }
            case .failure(let error):
                self?.showAlert(withTitle: "Ошибка", andMessage: error.description)
            }
        }
    }
                             
    private func showNewOrderAlert() {
     //   DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(
                title: "Заказ оформлен",
                message: "Поздравляем с покупкой!",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.clearCart()
                self?.delegate.openTab(with: .orders)
            }
            
            alert.addAction(okAction)
            
            present(alert, animated: true)
     //   }
    }
    
    private func showAlert(withTitle title: String, andMessage message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController.createAlert(withTitle: title, andMessage: message)
            alert.action(buttonTitle: "OK")
            self.present(alert, animated: true)
        }
    }
    
    private func authorize(on viewController: OrderListViewController?) {
        let alert = UIAlertController(
            title: "Авторизация",
            message: "Вы не вошли в программу. Авторизироваться сейчас?",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Да", style: .default) { _ in
            viewController?.performSegue(withIdentifier: "login", sender: nil)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    private func clearCart() {
        DataStore.shared.cart = []
        purchases = []
        clearIfCartIsEmpty()
    }
    
    @objc private func clearCartWithAlert() {

        let alert = UIAlertController(
            title: "Очистить корзину?",
            message: "Из корзины будут удалены все товары",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .destructive) { [weak self] _ in
            self?.clearCart()
            
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    private func clearIfCartIsEmpty() {
        if purchases.isEmpty {
            tableView.isHidden = true
            orderTextStack.isHidden = true
            navigationItem.rightBarButtonItem = .none
        } else {
            tableView.isHidden = false
            orderTextStack.isHidden = false
            navigationItem.rightBarButtonItem = clearBarButtonItem
        }
    }
    
    private func getTotalCartSum() {
        totalSum = 0
        for purchase in purchases {
            totalSum += purchase.totalPrice
        }
        DataStore.shared.cart = purchases
    }
    
}

// MARK: - UITableViewDataSource
extension PurchaseTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        purchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "PurchaseCell",
                for: indexPath
            ) as? PurchaseViewCell
        else {
            return UITableViewCell()
        }
                
        cell.delegate = self
        cell.purchase = purchases[indexPath.row]
        cell.configure()
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PurchaseTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            purchases.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            clearIfCartIsEmpty()
            getTotalCartSum()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - PurchaseViewCellDelegate
extension PurchaseTableViewController: PurchaseViewCellDelegate {

    func deleteFromCart(_ purchase: Purchase) {
        if let index = purchases.firstIndex(where: { $0 == purchase }) {
            purchases.remove(at: index)
            let indexPath = IndexPath(row: index, section: 0)
            tableView.deleteRows(at: [indexPath], with: .fade)
            clearIfCartIsEmpty()
        }
    }
    
    func calculateTotalSum(with purchase: Purchase) {
        if let index = purchases.firstIndex(where: { $0 == purchase }) {
            purchases[index] = purchase
        }
        getTotalCartSum()
    }
}
