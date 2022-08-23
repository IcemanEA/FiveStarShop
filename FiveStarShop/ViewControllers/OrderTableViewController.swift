//
//  PurchaseTableViewController.swift
//  FiveStarShop
//
//  Created by Dimondr on 30.07.2022.
//

import UIKit

class OrderTableViewController: UIViewController {
    // MARK: - IBOutlets and public properties
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var orderTextStack: UIStackView!
    @IBOutlet var totalSumLabel: UILabel!
    @IBOutlet var cartInButton: UIButton!
    
    var order: Order!
    
    // MARK: - private properties
    
    private var totalSum = 0 {
        didSet {
            totalSumLabel.text = totalSum.toRubleCurrency()
        }
    }
    
    // MARK: - override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        cartInButton.layer.cornerRadius = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backButtonTitle = "Назад"
        title = "Заказ № \(order.number) от \(order.getLocalizedDate())"
        getTotalCartSum()
    }
    
    // MARK: - IBActions
    
    @IBAction func repeatOrderButtonPressed() {
        let alert = UIAlertController(
            title: "Повторить заказ?",
            message: "Товары будут перемещены в Корзину",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
            DataStore.shared.cart = self?.order.purchases ?? []
                        
            self?.performSegue(withIdentifier: "unwindToOrders", sender: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    // MARK: - private methods
    
    private func getTotalCartSum() {
        totalSum = 0
        for purchase in order.purchases {
            totalSum += purchase.totalPrice
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let detailVC = segue.destination as? ProductDetailViewController else { return }
            detailVC.product = order.purchases[indexPath.row].product
        }
    }
}

// MARK: - UITableViewDataSource
extension OrderTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        order.purchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "PurchaseOrderCell",
                for: indexPath
            ) as? OrderViewCell
        else {
            return UITableViewCell()
        }
        
        cell.purchase = order.purchases[indexPath.row]
        cell.configure()
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension OrderTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
}
