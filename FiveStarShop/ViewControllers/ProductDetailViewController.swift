//
//  ProductDetailViewController.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 27/7/22.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var productDescription: UITextView!
    
    let product: Product? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productDescription.textContainer.lineFragmentPadding = 0
        
        image.image = UIImage(named: product?.article ?? "")
        name.text = product?.name
        price.text = product?.price.toRubleCurrency()
        productDescription.text = product?.description
    }
}
