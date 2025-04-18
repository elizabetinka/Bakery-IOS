//
//  UserAutentificationViewViews.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 17.04.2025.
//

import UIKit

extension UserAutentificationView {
    
    func createContentView (textLabel: UIView, phoneTextField: UITextField, loginButton: UIButton) -> UIView {
        let stack = UIView()
        
        stack.addSubview(textLabel)
        stack.addSubview(phoneTextField)
        stack.addSubview(loginButton)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: stack.topAnchor),
            textLabel.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant:15),
            textLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -15),
            
            phoneTextField.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 50),
            phoneTextField.heightAnchor.constraint(equalToConstant: 40),
            phoneTextField.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
        ])
        
        
        return stack
    }
    
}
