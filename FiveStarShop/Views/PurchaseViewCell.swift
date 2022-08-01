//
//  PurchaseViewCell.swift
//  FiveStarShop
//
//  Created by Dimondr on 27.07.2022.
//

import UIKit

class PurchaseViewCell: UITableViewCell {
    
    @IBOutlet var counterGoods: UILabel!
    
    @IBOutlet var purchaseImage: UIImageView!
    
    @IBOutlet var purchaseModel: UILabel!
    @IBOutlet var purchaseCompany: UILabel!
    @IBOutlet var purchaseArticle: UILabel!
    @IBOutlet var purchasePrice: UILabel!
    
    @IBOutlet var purchaseSum: UILabel!
    
    var purchaseDelegate: PurchaseViewCellDelegate!
    var purchase: Purchase! {
        didSet {
            purchaseSum.text = purchase.totalPrice.toRubleCurrency()
        }
    }
    
    @IBAction func minusButtonPressed() {
        var counter = purchase.count
        counter = counter - 1 <= 0 ? 0 : counter - 1
        if counter == 0 {
            purchaseDelegate.deleteFromCart(purchase)
        }
        counterGoods.text = counter.formatted()
        purchase.count = counter
        purchaseDelegate.calculateTotalSum(with: purchase)
    }
    
    @IBAction func plusButtonPressed() {
        var counter = purchase.count
        counter += 1
        counterGoods.text = counter.formatted()
        purchase.count = counter
        purchaseDelegate.calculateTotalSum(with: purchase)
    }
}
