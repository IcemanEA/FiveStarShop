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
    
    
    let product = Product(
        article: "EL0001",
        company: "Vitek",
        model: "Электрочайник",
        description: """
                    Особенности вращение на 360 градусов, индикатор уровня воды, дисплей
                    Возможность выбора температуры есть
                    Минимальная температура нагрева 60 °C
                    Количество температурных режимов 5
                    Материал корпуса металл
                    Материал колбы металл
                    Длина сетевого шнура 0.8 м
                    """,
        price: 1500
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productDescription.textContainer.lineFragmentPadding = 0
        
        image.image = UIImage(named: product.article)
        name.text = product.name
        price.text = "\(product.price)₽"
        productDescription.text = product.description
        
        

    }
    

   
}
