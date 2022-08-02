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
        
        let tempImage = UIImage(named: product.article) ?? UIImage(named: "imagePlaceholder.png")
        image.image = tempImage
        
        name.text = product.name
        price.text = product.price.toRubleCurrency()
        productDescription.text = product.description
    }
}
