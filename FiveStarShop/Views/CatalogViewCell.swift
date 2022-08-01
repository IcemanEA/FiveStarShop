//
//  CatalogViewCell.swift
//  FiveStarShop
//
//  Created by Dimondr on 27.07.2022.
//

import UIKit

class CatalogViewCell: UITableViewCell {
    
// MARK: - IBOutlets and public properties
    
    @IBOutlet var counterGoods: UILabel!
    
    @IBOutlet var purchaseImage: UIImageView!
    
    @IBOutlet var purchaseModel: UILabel!
    @IBOutlet var purchaseCompany: UILabel!
    @IBOutlet var purchaseArticle: UILabel!
    @IBOutlet var purchasePrice: UILabel!
    
    @IBOutlet var purchaseSum: UILabel!
    @IBOutlet var purchaseCountStack: UIStackView!
    @IBOutlet var cartButton: UIButton!
    
    var purchaseDelegate: CatalogViewCellDelegate!
    var purchase: Purchase! {
        didSet {
            purchaseSum.text = purchase.totalPrice.toRubleCurrency()
        
            cartButton.isHidden = purchase.count > 0
            purchaseCountStack.isHidden = !cartButton.isHidden
        }
    }
    
// MARK: - IBActions
    
    @IBAction func minusButtonPressed() {
        var counter = purchase.count
        counter = counter - 1 <= 0 ? 0 : counter - 1
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
