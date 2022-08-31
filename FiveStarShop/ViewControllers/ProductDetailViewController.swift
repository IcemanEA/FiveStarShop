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
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = product.name
        price.text = (product.price ?? 0).toRubleCurrency()
        productDescription.text = product.description
        
        updateImage()
        image.layer.cornerRadius = 10
    }
    
    // MARK: - Private functions
    
    private func updateImage() {
        guard let url = getImageURL(for: product.article) else { return }
        getImage(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.image.image = image
            case .failure(let error):
                print(error)
                self?.image.image = UIImage(named: "imagePlaceholder.png")
            }
        }
    }
}
