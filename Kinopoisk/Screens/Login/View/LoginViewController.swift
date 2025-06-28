//
//  LoginViewController.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import UIKit

final class LoginViewController: UIViewController {
    
    var presenter: LoginPresenter?
    
    private let container: UIView = {
        let container = UIView()
        return container
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Кинопоиск"
        nameLabel.textColor = .cyan
        nameLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    private let userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        userNameTextField.textColor = .lightGray
        userNameTextField.attributedPlaceholder = NSAttributedString(
            string: "Введите логин",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.layer.borderColor = UIColor.lightGray.cgColor
        userNameTextField.layer.borderWidth = 1
        userNameTextField.backgroundColor = .black
        userNameTextField.layer.cornerRadius = 8
        return userNameTextField
    }()
    
    private let userPasswordTextField: UITextField = {
        let userPasswordTextField = UITextField()
        userPasswordTextField.textColor = .lightGray
        userPasswordTextField.attributedPlaceholder = NSAttributedString(
            string: "Введите пароль",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        userPasswordTextField.layer.cornerRadius = 8
        userPasswordTextField.isSecureTextEntry = true
        userPasswordTextField.layer.borderWidth = 1
        userPasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        userPasswordTextField.borderStyle = .roundedRect
        userPasswordTextField.backgroundColor = .black
        return userPasswordTextField
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Войти", for: .normal)
        loginButton.tintColor = .white
        loginButton.backgroundColor = .cyan
        loginButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        loginButton.layer.cornerRadius = 8
        loginButton.addAction(
            UIAction { [weak self] _ in
                self?.tappedLoginButton()
            },
            for: .touchUpInside)
        return loginButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        TextFieldDelegate()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(container)
        container.addSubview(nameLabel)
        container.addSubview(userNameTextField)
        container.addSubview(userPasswordTextField)
        container.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        container.addConstraints(constraints: [
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        nameLabel.addConstraints(constraints: [
            nameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 125),
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            nameLabel.heightAnchor.constraint(equalToConstant: 44),
        ])
        userNameTextField.addConstraints(constraints: [
            userNameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 44),
            userNameTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            userNameTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            userNameTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        userPasswordTextField.addConstraints(constraints: [
            userPasswordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 16),
            userPasswordTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            userPasswordTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            userPasswordTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        loginButton.addConstraints(constraints: [
            loginButton.topAnchor.constraint(equalTo: userPasswordTextField.bottomAnchor, constant: 44),
            loginButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            loginButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            loginButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func TextFieldDelegate() {
        userNameTextField.delegate = self
        userPasswordTextField.delegate = self
    }
    
    private func tappedLoginButton() {
        presenter?.hadleAuth(
            login: userNameTextField.text,
            password: userPasswordTextField.text
        )
        userNameTextField.text = ""
        userPasswordTextField.text = ""
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            userPasswordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension LoginViewController: LoginView {
}
