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
    
    var orderDelegate: OrderViewCellDelegate!
    var purchase: Purchase! {
        didSet {
            purchaseSum.text = purchase.totalPrice.toRubleCurrency()
        }
    }

    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
