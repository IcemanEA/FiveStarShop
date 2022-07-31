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
        
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var orderTextStack: UIStackView!
    @IBOutlet var totalSumLabel: UILabel!
    @IBOutlet var cartInButton: UIButton!
    
    var purchases: [Purchase]! {
        didSet {
            title = "Корзина (\(purchases.count))"
        }
    }
    
    private var totalSum = 0 {
        didSet {
            totalSumLabel.text = totalSum.toRubleCurrency()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
// TODO: purchases должны прилететь с экрана товары
        purchases = Purchase.getPurchases(DataStore.shared.products)
// до этой строки
        
        cartInButton.layer.cornerRadius = 15
        
        clearIfCartIsEmpty()
        
        getTotalCartSum()
        
    }
    
    @IBAction func cartInButtonPressed() {

// TODO: тут надо перейти в заказы и передать туда сформированный заказ
        
        for purchase in purchases {
            print("\(purchase.product.article) - \(purchase.count)")
        }
        
        
    }
// до этой строки
    
    @IBAction func clearButtonPressed() {

        let alert = UIAlertController(
            title: "Очистить корзину?",
            message: "Из корзины будут удалены все товары",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .destructive) { [weak self] _ in
                    self?.purchases = []
                    self?.clearIfCartIsEmpty()
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
        }
    }
    
    private func getTotalCartSum() {
        totalSum = 0
        for purchase in purchases {
            totalSum += purchase.totalPrice
        }
    }
    
}

// MARK: - UITableViewDataSource
extension PurchaseTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        purchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "PurchaseCell",
            for: indexPath
        ) as? PurchaseViewCell
        else
        {
            return UITableViewCell()
        }
        
        let purchase = purchases[indexPath.row]
        
        cell.purchaseDelegate = self
        cell.purchase = purchase
        
        cell.counterGoods.text = purchase.count.formatted()
        cell.purchaseModel.text = purchase.product.model
        cell.purchaseCompany.text = purchase.product.company
        cell.purchaseArticle.text = purchase.product.article
        cell.purchasePrice.text = purchase.product.price.toRubleCurrency() + "/шт."
        cell.purchaseSum.text = purchase.totalPrice.toRubleCurrency()
        cell.purchaseImage.image = UIImage(named: purchase.product.article)
        cell.purchaseImage.layer.cornerRadius = 10
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PurchaseTableViewController: UITableViewDelegate {
    
// TODO: удалить может этот блок ???????
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
// ибо мы по нажатию на ячейку уходим в детализацию и снятие выделения не так необходимо
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }

// TODO: на этой функции приложение крашится в момент удаления ячейки смахиванием
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            tableView.deleteRows(at: [indexPath], with: .left)
//                purchases.remove(at: indexPath.row)
//                clearIfCartIsEmpty()
//        }
//    }
    
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
