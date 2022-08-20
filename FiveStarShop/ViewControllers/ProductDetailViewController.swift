//
//  ProductDetailViewController.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 27/7/22.
//

import UIKit

class ProductDetailViewController: UIViewController, ProductCellProtocol {
    // MARK: - IBOutlets and properties
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var productDescription: UILabel!
    
    var product: Product!
    private var imageURL: URL?
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = product.name
        price.text = (product.price ?? 0).toRubleCurrency()
        productDescription.text = product.description
        imageURL = getImageURL(for: product.article)
        updateImage()
    }
    
    override func viewWillLayoutSubviews() {
        image.layer.cornerRadius = image.frame.height / 10
    }
    
    // MARK: - Private functions
    
    private func updateImage() {
        guard let updateImageURL = imageURL else { return }
        getImage(from: updateImageURL) { [weak self] result in
            switch result {
            case .success(let image):
                if updateImageURL == self?.imageURL {
                    self?.image.image = image
                }
            case .failure(let error):
                print(error)
                self?.image.image = UIImage(named: "imagePlaceholder.png")
            }
        }
    }
}
