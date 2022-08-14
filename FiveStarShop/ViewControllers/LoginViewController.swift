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
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var loginBtn: UIButton!
    
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
        updateUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    // MARK: - Login screen buttons setup
    
    @IBAction func logInSCChanged(_ sender: UISegmentedControl) {
        updateUI(sender.selectedSegmentIndex)
    }
    
    
    @IBAction func loginBtnPressed() {
        guard
            userTextField.text != "",
            let username = userTextField.text,
            passwordTextField.text != "",
            let password = passwordTextField.text
        else {
            showAlert(
                title: "Неверный ввод",
                message: "Пожалуйста, введите имя пользователя и пароль!"
            )
            return
        }
        var userCredits = [
            "username": username,
            "password": password
        ]
        if !nameTextField.isHidden {
            guard nameTextField.text != "" else {
                showAlert(
                    title: "Неверный ввод",
                    message: "Пожалуйста, введите Ваше имя!"
                )
                return
            }
            
            userCredits["name"] = nameTextField.text
            registration(requestBody: userCredits)
        } else {
            logIn(requestBody: userCredits)
        }
    }
    
    @IBAction func cancelBtnPressed() {
        dismiss(animated: true)
    }
    
    // MARK: - Alert message setup
    
    private func updateUI(_ index: Int = 0) {
        if index == 0 {
            loginBtn.setTitle("Войти", for: .normal)
            nameTextField.isHidden = true
        } else {
            loginBtn.setTitle("Зарегистрироваться", for: .normal)
            nameTextField.isHidden = false
        }
    }
    
    private func registration(requestBody: [String: String]) {
        NetworkManager.shared.postRequest(
            with: requestBody,
            to: NetworkManager.shared.getLink(.registration)) { [weak self] result in
                switch result {
                case .success(let data):
                    guard
                        let user = try? JSONDecoder().decode(User.self, from: data)
                    else { return }

                    DispatchQueue.main.async {
                        self?.delegate.setUser(user)
                        self?.dismiss(animated: true)
                    }
                case .failure(let error):
                    print(error)
                    if error == .dublicateUser {
                        self?.showAlert(
                            title: "Пользователь существует!",
                            message: "Пожалуйста, введите новые данные!"
                        )
                    }
                }
            }
    }
    
    private func logIn(requestBody: [String: String]) {
        NetworkManager.shared.postRequest(
            with: requestBody,
            to: NetworkManager.shared.getLink(.authentication)) { [weak self] result in
                switch result {
                case .success(let data):
                    guard
                        let user = try? JSONDecoder().decode(User.self, from: data)
                    else { return }

                    DispatchQueue.main.async {
                        self?.delegate.setUser(user)
                        self?.dismiss(animated: true)
                    }
                case .failure(let error):
                    print(error)
                    if error == .notFound {
                        self?.showAlert(
                            title: "Неверный логин или пароль!",
                            message: "Пожалуйста, введите корректные данные!"
                        )
                    }
                }
            }
    }
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                textField?.text = ""
            }
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
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
