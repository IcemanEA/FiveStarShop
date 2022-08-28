//
//  CatalogViewCell.swift
//  FiveStarShop
//
//  Created by Dimondr on 27.07.2022.
//

import UIKit

class CatalogViewCell: UITableViewCell, ProductCellProtocol {
    
    // MARK: - IBOutlets and public properties
    
    @IBOutlet var counterGoods: UILabel!
    
    @IBOutlet var productImageView: UIImageView!
    
    @IBOutlet var modelLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var articleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var sumLabel: UILabel!
    @IBOutlet var countStackView: UIStackView!
    @IBOutlet var cartButton: UIButton!
    
    var delegate: CatalogViewCellDelegate!
    var purchase: Purchase! {
        didSet {
            sumLabel.text = purchase.totalPrice.toRubleCurrency()
        
            cartButton.isHidden = purchase.count > 0
            countStackView.isHidden = !cartButton.isHidden
        }
    }
    
    private var imageURL: URL? {
        didSet {
            productImageView.image = nil
            updateImage()
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func minusButtonPressed() {
        var counter = purchase.count
        counter = counter - 1 <= 0 ? 0 : counter - 1
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
        DispatchQueue.main.async { [unowned self] in
            counterGoods.text = purchase.count.formatted()
            modelLabel.text = purchase.product.model
            companyLabel.text = purchase.product.company
            articleLabel.text = purchase.product.article
            priceLabel.text = (purchase.product.price ?? 0).toRubleCurrency() + "/шт."
            sumLabel.text = purchase.totalPrice.toRubleCurrency()
            productImageView.layer.cornerRadius = 10
            
            imageURL = getImageURL(for: purchase.product.article)
        }
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
    
//    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
//        // Загружаем из кэша
//        if let cachedImage = ImageCacheManager.shared.object(forKey: url.lastPathComponent as NSString) {
//            print("Image from cache: ", url.lastPathComponent)
//            completion(.success(cachedImage))
//            return
//        }
//
//        // Загружаем из сети
//        NetworkManager.shared.fetchImage(from: url) { result in
//            switch result {
//            case .success(let imageData):
//                guard let uiImage = UIImage(data: imageData) else { return }
//                ImageCacheManager.shared.setObject(uiImage, forKey: url.lastPathComponent as NSString)
//                print("Image form NET", url.lastPathComponent)
//                completion(.success(uiImage))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//
//    }
}
