//
//  ShoppingCartTableViewController.swift
//  FiveStarShop
//
//  Created byDimondr on 27.07.2022.
//

import UIKit

class ShoppingCartTableViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }    
    
}

// MARK: - UITableViewDataSource
extension ShoppingCartTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        default:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "GoodCell",
                for: indexPath
            ) as? GoodsCartTableViewCell
            else
            {
                return UITableViewCell()
            }
            
            let goods = DataStore.shared.getGoods(DataStore.shared.products)
            let good = goods[indexPath.row]
            
            cell.counterGoods.text = good.count.formatted()
            cell.goodsModel.text = good.product.model
            cell.goodsCompany.text = good.product.company
            cell.goodsArticle.text = good.product.article
            cell.goodsPrice.text = good.product.rubleCurrency
            cell.goodsSum.text = good.rubleCurrency
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GoodCell", for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = indexPath.section.formatted() + "-" + indexPath.row.formatted()
            cell.contentConfiguration = content
            return cell
        }
        
    }
    
}

extension ShoppingCartTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //    tableView.allowsSelection = false
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
}


