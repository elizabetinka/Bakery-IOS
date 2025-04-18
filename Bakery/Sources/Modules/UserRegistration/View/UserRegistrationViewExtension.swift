//
//  h.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 17.04.2025.
//

import Foundation

import UIKit

extension UserRegistrationView {
    
    func createContentView(registrationTextLabel:UIView, nameTextLabel:UIView, nameTextField:UITextField, phoneTextLabel:UIView, phoneTextField:UITextField, registrationButton:UIButton) -> UIView {
        
        let stack = UIView()
        
        stack.addSubview(registrationTextLabel)
        stack.addSubview(nameTextLabel)
        stack.addSubview(nameTextField)
        stack.addSubview(phoneTextLabel)
        stack.addSubview(phoneTextField)
        stack.addSubview(registrationButton)
        
        registrationTextLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            registrationTextLabel.topAnchor.constraint(equalTo: stack.topAnchor),
            registrationTextLabel.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant:15),
            registrationTextLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -15),
            
            nameTextLabel.topAnchor.constraint(equalTo: registrationTextLabel.bottomAnchor, constant: 40),
            nameTextLabel.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant:15),
            nameTextLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -15),
            
            nameTextField.topAnchor.constraint(equalTo: nameTextLabel.bottomAnchor, constant: 10),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            nameTextField.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            
            phoneTextLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            phoneTextLabel.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant:15),
            phoneTextLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -15),
            
            phoneTextField.topAnchor.constraint(equalTo: phoneTextLabel.bottomAnchor, constant: 10),
            phoneTextField.heightAnchor.constraint(equalToConstant: 40),
            phoneTextField.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            
            registrationButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 80),
            registrationButton.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
        ])
        
        
        return stack
    }
    
}
