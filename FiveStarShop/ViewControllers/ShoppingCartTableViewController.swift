//
//  ShoppingCartTableViewController.swift
//  FiveStarShop
//
//  Created byDimondr on 27.07.2022.
//

import UIKit

protocol GoodCartCellDelegate {
    func calculateTotalSum(with cart: Cart)
    func deleteFromCart(_ cart: Cart)
}

class ShoppingCartTableViewController: UIViewController {
        
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var orderTextLabel: UILabel!
    @IBOutlet var totalSumLabel: UILabel!
    @IBOutlet var cartInButton: UIButton!
    
    @IBOutlet var clearButton: UIBarButtonItem!
    
    var goods: [Cart]!
    
    private var totalSum = 0 {
        didSet {
            totalSumLabel.text = totalSum.formatted(
                .number.grouping(.automatic).locale(Locale(identifier: "ru_RU"))
            ) + "₽"
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        totalSumLabel.text = "\(totalSum) ₽"
        
        // передать нормальную корзину сюда
        goods = Cart.getCartGoods(DataStore.shared.products)
        
        cartInButton.layer.cornerRadius = 15
        
        title = "Корзина (\(goods.count))"
        
        clearIfIsEmpty(cart: goods)
        
        getTotalCartSum()
        
    }
    
    @IBAction func cartInButtonPressed() {
        // перейти по сегвею на экран Заказы
        
        for good in goods {
            print("\(good.product.article) - \(good.count)")
        }
    }
    
    @IBAction func clearButtonPressed() {
        showAlert(title: "Внимание!", message: """
                    Это действие удалит ВСЕ товары из корзины.
                    Очистить корзину?
                    """)
    }
    
    private func clearIfIsEmpty(cart: [Cart]) {
        if cart == [] {
            tableView.isHidden = true
            cartInButton.isHidden = true
            orderTextLabel.isHidden = true
            totalSumLabel.isHidden = true
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive) { (action) in
            self.goods = []
            self.clearIfIsEmpty(cart: self.goods)
            self.title = "Корзина (\(self.goods.count))"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

// MARK: - UITableViewDataSource
extension ShoppingCartTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goods.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "GoodCell",
            for: indexPath
        ) as? GoodsCartTableViewCell
        else
        {
            return UITableViewCell()
        }
        
        let good = goods[indexPath.row]
        
        cell.delegate = self
        cell.good = good
        
        cell.counterGoods.text = good.count.formatted()
        cell.goodsModel.text = good.product.model
        cell.goodsCompany.text = good.product.company
        cell.goodsArticle.text = good.product.article
        cell.goodsPrice.text = good.product.rubleCurrency
        cell.goodsSum.text = good.rubleCurrency
        cell.goodsImage.image = UIImage(named: good.product.article)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ShoppingCartTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //    tableView.allowsSelection = false
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

extension ShoppingCartTableViewController: GoodCartCellDelegate {

    func deleteFromCart(_ good: Cart) {
        if let index = goods.firstIndex(where: { $0 == good }) {
            goods.remove(at: index)
            let indexPath = IndexPath(row: index, section: 0)
            tableView.deleteRows(at: [indexPath], with: .fade)
            title = "Корзина (\(goods.count))"
            clearIfIsEmpty(cart: goods)
        }
    }
    
    func calculateTotalSum(with good: Cart) {
        if let index = goods.firstIndex(where: { $0 == good }) {
            goods[index] = good
        }
        
        getTotalCartSum()
    }
    
    func getTotalCartSum() {
        totalSum = 0
        for good in goods {
            totalSum += good.totalPrice
        }
    }
    
}
