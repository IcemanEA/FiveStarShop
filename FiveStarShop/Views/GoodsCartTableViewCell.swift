//
//  GoodsCartTableViewCell.swift
//  FiveStarShop
//
//  Created by Dimondr on 27.07.2022.
//

import UIKit

class GoodsCartTableViewCell: UITableViewCell {
    
    @IBOutlet var counterGoods: UILabel!
    
    @IBOutlet var goodsImage: UIImageView!
    
    @IBOutlet var goodsModel: UILabel!
    @IBOutlet var goodsCompany: UILabel!
    @IBOutlet var goodsArticle: UILabel!
    @IBOutlet var goodsPrice: UILabel!
    
    @IBOutlet var goodsSum: UILabel!
    
    var delegate: GoodCartCellDelegate!
    var good: Cart! {
        didSet {
            goodsSum.text = good.rubleCurrency
        }
    }
//    var cart: Cart!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        //            backgroundColor = UIColor.separator
//        if let cart = cart {
//            goodsSum.text = cart.rubleCurrency
//
//        }
//    }
    
    @IBAction func minusButtonPressed() {
        guard var counter = Int(counterGoods.text ?? "0") else { return }
        
        if counter == 0 {
            delegate.deleteFromCart(good)
        }
        
        counter = counter - 1 <= 0 ? 0 : counter - 1
        
        counterGoods.text = counter.formatted()
        good.count = counter
        delegate.calculateTotalSum(with: good)
    }
    
    @IBAction func plusButtonPressed() {
        guard var counter = Int(counterGoods.text ?? "0") else { return }
        counter += 1
        counterGoods.text = counter.formatted()
        good.count = counter
        delegate.calculateTotalSum(with: good)
    }
    
    //    @objc private func didTapDone() {
    //        super.endEditing(true)
    //    }
    //
    //    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        super.touchesEnded(touches, with: event)
    //        counterGoods.endEditing(true)
    //    }
    
    //    private func showAlert(title: String, message: String) {
    //        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    //        let okAction = UIAlertAction(title: "OK", style: .default)
    //        alert.addAction(okAction)
    //        delegate.present(alert, animated: true)
    //    }
    
}


// MARK: - UITextFieldDelegate
extension GoodsCartTableViewCell: UITextFieldDelegate {
    
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //        textField.resignFirstResponder()
    //    }
    
    //    func textFieldDidEndEditing(_ textField: UITextField) {
    //
    //        guard let text = textField.text else { return }
    //
    //        if let currentValue = Float(text) {
    //            // устанавливаем значение количества продукта
    //            return
    //        }
    ////        showAlert(title: "Wrong format!", message: "Please enter correct value")
    //    }
    
    //    func textFieldDidBeginEditing(_ textField: UITextField) {
    //        let keyboardToolbar = UIToolbar()
    //        keyboardToolbar.sizeToFit()
    //        textField.inputAccessoryView = keyboardToolbar
    //
    //        let doneButton = UIBarButtonItem(
    //            barButtonSystemItem: .done,
    //            target: self,
    //            action: #selector(didTapDone)
    //        )
    //
    //        let flexBarButton = UIBarButtonItem(
    //            barButtonSystemItem: .flexibleSpace,
    //            target: nil,
    //            action: nil
    //        )
    //
    //        keyboardToolbar.items = [flexBarButton, doneButton]
    //    }
}
