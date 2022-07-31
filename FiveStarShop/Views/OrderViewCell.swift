//
//  OrderViewCell.swift
//  FiveStarShop
//
//  Created by Dimondr on 30.07.2022.
//

import UIKit

class OrderViewCell: UITableViewCell {
    
    @IBOutlet var counterGoods: UILabel!
    
    @IBOutlet var purchaseImage: UIImageView!
    
    @IBOutlet var purchaseModel: UILabel!
    @IBOutlet var purchaseCompany: UILabel!
    @IBOutlet var purchaseArticle: UILabel!
    @IBOutlet var purchasePrice: UILabel!
    
    @IBOutlet var purchaseSum: UILabel!
    
    var purchase: Purchase! {
        didSet {
            purchaseSum.text = purchase.totalPrice.toRubleCurrency()
        }
    }
    
}
