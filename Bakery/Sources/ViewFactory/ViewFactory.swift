//
//  ViewFactory.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 17.04.2025.
//

import UIKit



public struct ViewFactory {
    
    static func getButton(with text: String, onTap: @escaping () -> Void) -> UIButton {
        
        let action = UIAction { _ in
                onTap()
        }
        
        let button = UIButton(type: .system, primaryAction: action)
        button.setTitle(text, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive=true
        
        Appearance.buttonApplyAppereance(button: button, isValid: true)
        return button
    }
    
    static func getTextField(placeholder: String = "", onTextChanged: @escaping (UITextField) -> Void) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        
        Appearance.textFieldApplyAppereance(textField: textField, isValid: true)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        let action = UIAction { [weak textField] _ in
            if let textField = textField {
                onTextChanged(textField)
            }
        }

        textField.addAction(action, for: .editingChanged)
        return textField
    }
    
    static func getLogoImageView(image: UIImage = Appearance.LogoImage.image) -> UIImageView {
        let imageView = UIImageView(image: image)
        return imageView
    }
    
    static func getTitleLable(title : String,  level : Appearance.TitleLabel.TitleFont  = .Level2) -> UIView {
        let text =  UILabel()
        text.text = title
    
        Appearance.textLabelApplyAppereance(textLabel: text, level: level)
    
        let mainView = UIView()
        text.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(text)
        text.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        text.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        mainView.heightAnchor.constraint(equalTo: text.heightAnchor, multiplier: 2).isActive = true
    
        return mainView
    }
    
    static func getErrorView (refreshDelegate: ErrorViewDelegate?) -> ErrorView {
        let view = ErrorView()
        view.delegate = refreshDelegate
        return view
    }
    
    static func getScrollView () -> UIScrollView {
        return UIScrollView()
    }
}
