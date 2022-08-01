//
//  LogOffViewController.swift
//  FiveStarShop
//
//  Created by Psycho on 28.07.2022.
//

import UIKit

class UserMenuViewController: UIViewController {
    
    @IBOutlet var welcomeLabel: UILabel!
    
    var user: User!
    var delegate: LoginViewControllerDelegate!
   
    private let primaryColor = UIColor(
        red: 210/255,
        green: 109/255,
        blue: 128/255,
        alpha: 1
    )
    private let secondaryColor = UIColor(
        red: 107/255,
        green: 148/255,
        blue: 230/255,
        alpha: 1
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        welcomeLabel.text = "Приятных покупок, \(user.name)!"
    }
  
    // MARK: - User menu buttons setup
    
    @IBAction func logOutBtnPressed() {
        delegate.logOutUser()
        dismiss(animated: true)
    }
    
    @IBAction func backBtnPressed() {
        dismiss(animated: true)
    }
}
