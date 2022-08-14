//
//  ProductDetailViewController.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 27/7/22.
//

import UIKit

class ProductDetailViewController: UIViewController {

// MARK: - IBOutlets
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var productDescription: UILabel!
    
    var product: Product!
    
// MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let link = NetworkManager.shared.getLink(.images) + product.article + ".jpg"
        
        NetworkManager.shared.fetchImage(from: link) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.image.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
                self?.image.image = UIImage(named: "imagePlaceholder.png")
            }
        }
        
        name.text = product.name
        price.text = product.price.toRubleCurrency()
        productDescription.text = product.description
    }
    
    override func viewWillLayoutSubviews() {
        image.layer.cornerRadius = image.frame.height / 10
    }
}
