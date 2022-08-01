//
//  PurchaseTableViewController.swift
//  FiveStarShop
//
//  Created by Dimondr on 30.07.2022.
//

import UIKit

class OrderTableViewController: UIViewController {
        
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var orderTextStack: UIStackView!
    @IBOutlet var totalSumLabel: UILabel!
    @IBOutlet var cartInButton: UIButton!
    
    var order: Order!
    
    private var totalSum = 0 {
        didSet {
            totalSumLabel.text = totalSum.toRubleCurrency()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartInButton.layer.cornerRadius = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "Заказ № \(order.id) от \(order.date)"
        getTotalCartSum()
    }
    
    @IBAction func repeatOrderButtonPressed() {
        let alert = UIAlertController(
            title: "Повторить заказ?",
            message: "Товары будут перемещены в Корзину",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Да", style: .default)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true)
        
// TODO: тут надо перейти в заказы и передать туда сформированный заказ
// желательно пометить этот заказ как "новый"
        
        for purchase in order.purchases {
            print("\(purchase.product.article) - \(purchase.count)")
        }
        
        
    }
// до этой строки
    
    private func getTotalCartSum() {
        totalSum = 0
        for purchase in order.purchases {
            totalSum += purchase.totalPrice
        }
    }
    
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

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "PurchaseOrderCell",
            for: indexPath
        ) as? OrderViewCell
        else
        {
            return UITableViewCell()
        }
        
        let purchase = order.purchases[indexPath.row]
        
        cell.purchase = purchase
        
        cell.counterGoods.text = purchase.count.formatted() + " шт."
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
extension OrderTableViewController: UITableViewDelegate {
    
// TODO: удалить может этот блок ???????
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
// ибо мы по нажатию на ячейку уходим в детализацию и снятие выделения не так необходимо
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
}
