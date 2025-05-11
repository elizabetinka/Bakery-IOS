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
    
    static func getTitleLable(title : String,  level : Appearance.TitleLabel.TitleFont  = .Level2) -> UILabel {
        let text =  UILabel()
        text.text = title
    
        Appearance.textLabelApplyAppereance(textLabel: text, level: level)
        return text
    }
    
    static func getErrorView (refreshDelegate: ErrorViewDelegate?) -> ErrorView {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 300).isActive=true
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return view
    }
    
    static func getScrollView () -> UIScrollView {
        return UIScrollView()
    }
    
    static func getActivityIndicator () -> UIActivityIndicatorView {
        let ind = UIActivityIndicatorView(style: .large)
        ind.hidesWhenStopped = true
        return ind
    }
    
    static func getRefreshControl (delegate: @escaping () -> Void) -> UIRefreshControl {
        
        let action = UIAction { _ in
            delegate()
        }
        
        let ans = UIRefreshControl()
        ans.addAction(action, for: .valueChanged)
        Appearance.refreshControlApplyAppereance(refreshControl: ans)
        return ans
    }
}
