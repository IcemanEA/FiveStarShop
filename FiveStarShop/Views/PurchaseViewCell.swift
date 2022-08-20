//
//  PurchaseViewCell.swift
//  FiveStarShop
//
//  Created by Dimondr on 27.07.2022.
//

import UIKit

class PurchaseViewCell: UITableViewCell, ProductCellProtocol {
    
    // MARK: - @IBOutlets and properties
    
    @IBOutlet var productImageView: UIImageView!
    
    @IBOutlet var modelLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var articleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var counterGoods: UILabel!
    @IBOutlet var sumLabel: UILabel!
    
    var delegate: PurchaseViewCellDelegate!
    var purchase: Purchase! {
        didSet {
            sumLabel.text = purchase.totalPrice.toRubleCurrency()
        }
    }
    
    private var imageURL: URL?
    
    // MARK: - @IBActions
    
    @IBAction func minusButtonPressed() {
        var counter = purchase.count
        counter = counter - 1 <= 0 ? 0 : counter - 1
        if counter == 0 {
            delegate.deleteFromCart(purchase)
        }
        counterGoods.text = counter.formatted()
        purchase.count = counter
        delegate.calculateTotalSum(with: purchase)
    }
    
    @IBAction func plusButtonPressed() {
        var counter = purchase.count
        counter += 1
        counterGoods.text = counter.formatted()
        purchase.count = counter
        delegate.calculateTotalSum(with: purchase)
    }
    
    // MARK: - Configure UI
    
    func configure() {
        
        counterGoods.text = purchase.count.formatted()
        modelLabel.text = purchase.product.model
        companyLabel.text = purchase.product.company
        articleLabel.text = purchase.product.article
        priceLabel.text = (purchase.product.price ?? 0).toRubleCurrency() + "/шт."
        sumLabel.text = purchase.totalPrice.toRubleCurrency()
        
        productImageView.layer.cornerRadius = 10
        
        imageURL = getImageURL(for: purchase.product.article)
        updateImage()
    }
    
    // MARK: - Private functions
    
    private func updateImage() {
        guard let updateImageURL = imageURL else { return }
        getImage(from: updateImageURL) { [weak self] result in
            switch result {
            case .success(let image):
                if updateImageURL == self?.imageURL {
                    self?.productImageView.image = image
                }
            case .failure(let error):
                print(error)
                self?.productImageView.image = UIImage(named: "imagePlaceholder.png")
            }
        }
    }
}
