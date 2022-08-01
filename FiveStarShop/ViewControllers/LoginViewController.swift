//
//  LoginViewController.swift
//  FiveStarShop
//
//  Created by Psycho on 27.07.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    var users: [User]!
    var delegate: LoginViewControllerDelegate!
    
    private var user: User!
    
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
        user = users.first
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    // MARK: - Login screen buttons setup
    
    @IBAction func loginBtnPressed() {
        guard userTextField.text == user.userName, passwordTextField.text == user.password else {
            showAlert(
                title: "Неверный логин или пароль!",
                message: "Пожалуйста, введите корректные данные!"
            )
            return
        }
        
        delegate.setUser(user)
        dismiss(animated: true)
    }
    
    @IBAction func forgotLoginData(_ sender: UIButton) {
        sender.tag == 0
        ? showAlert(title: "Ой!", message: "Ваш логин - \(user.userName)")
        : showAlert(title: "Ой!", message: "Ваш пароль - \(user.password)")
    }
    
    @IBAction func cancelBtnPressed() {
        dismiss(animated: true)
    }
    
    // MARK: - Alert message setup
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Set background color

extension UIView {
    func addVerticalGradientLayer(topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }
}
