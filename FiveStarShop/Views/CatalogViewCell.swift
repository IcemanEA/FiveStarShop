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
    
    // MARK: - Configure UI
    func configure() {
        
        counterGoods.text = purchase.count.formatted()
        purchaseModel.text = purchase.product.model
        purchaseCompany.text = purchase.product.company
        purchaseArticle.text = purchase.product.article
        purchasePrice.text = purchase.product.price.toRubleCurrency() + "/шт."
        purchaseSum.text = purchase.totalPrice.toRubleCurrency()
        purchaseImage.layer.cornerRadius = 10
                
        let link = NetworkManager.shared.getLink(.images) + purchase.product.article + ".jpg"
        
        NetworkManager.shared.fetchImage(from: link) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.purchaseImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
                self?.purchaseImage.image = UIImage(named: "imagePlaceholder.png")
            }
        }
    }
}
