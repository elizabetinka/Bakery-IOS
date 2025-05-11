//
//  AppereanceViews.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 17.04.2025.
//

import Foundation

import UIKit

struct Appearance {
    
    struct MainView {
        static let backgroundColor: UIColor = .white
    }
    
    struct TitleLabel {
        
        enum TitleFont {
            case Level1
            case Level2
        }
        
        static let  textAlignment =  NSTextAlignment.center
        static let  textColor =  UIColor.gray
        static let  fontLevel1 = UIFont.systemFont(ofSize: 30, weight: .bold)
        static let  fontLevel2 = UIFont.systemFont(ofSize: 17, weight: .medium)
        static let  numberOfLines = 0
        static let  lineBreakMode = NSLineBreakMode.byWordWrapping
        static let  adjustsFontSizeToFitWidth = false
    }
    
    struct TextField {
        
        struct Valid {
            static let borderColor = UIColor.gray.cgColor
        }
        
        struct Invalid {
            static let borderColor = UIColor.red.cgColor
            
            static let animation : CAKeyframeAnimation = {
                let animation = CAKeyframeAnimation(keyPath: "position.x")
                animation.values = [0, 10, -10, 10, 0]
                animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
                animation.duration = 0.4
                animation.isAdditive = true
                return animation
            }()
        }
        
        static let borderWidth: CGFloat = 1
        static let borderStyle = UITextField.BorderStyle.roundedRect
        static let keyboardType = UIKeyboardType.namePhonePad
        static let cornerRadius : CGFloat = 15
        static let backgroundColor = UIColor.gray
        static let textColor = UIColor.white
    }
    
    struct Button {
        
        struct Normal {
            static let titleColor =  UIColor.white
            static let backgroundColor =  UIColor.appSoftBlue
        }
        
        struct Selected {
            static let backgroundColor =  UIColor.appBlue
        }
        
        struct Disabled {
            static let backgroundColor =  UIColor.gray
        }
        
        static let cornerRadius : CGFloat = 8
    }
    
    struct LogoImage {
        static let image: UIImage = .logo
    }
    
    struct RefreshControl {
        static let attributedTitle = "Обновление данных..."
    }
    
    static func refreshControlApplyAppereance(refreshControl: UIRefreshControl) {
        refreshControl.attributedTitle = NSAttributedString(string: RefreshControl.attributedTitle)
    }
    
    static func mainViewApplyAppereance(view : UIView) {
        view.backgroundColor = Appearance.MainView.backgroundColor
    }
    
    static func textLabelApplyAppereance(textLabel: UILabel, level : Appearance.TitleLabel.TitleFont  = .Level2) {
        textLabel.textAlignment = Appearance.TitleLabel.textAlignment
        textLabel.textColor = Appearance.TitleLabel.textColor
        switch level {
        case .Level1:
            textLabel.font = Appearance.TitleLabel.fontLevel1
        case .Level2:
            textLabel.font = Appearance.TitleLabel.fontLevel2
        }
        textLabel.numberOfLines = Appearance.TitleLabel.numberOfLines
        textLabel.lineBreakMode = Appearance.TitleLabel.lineBreakMode
        textLabel.adjustsFontSizeToFitWidth = Appearance.TitleLabel.adjustsFontSizeToFitWidth
    }
    
    static func textFieldApplyAppereance(textField: UITextField, isValid: Bool) {
        
        textField.keyboardType = Appearance.TextField.keyboardType
        textField.backgroundColor = Appearance.TextField.backgroundColor
        textField.textColor = Appearance.TextField.textColor
        textField.layer.borderWidth = Appearance.TextField.borderWidth
        textField.layer.cornerRadius = Appearance.TextField.cornerRadius
        
        
        if isValid {
            textField.layer.borderColor =  Appearance.TextField.Valid.borderColor
        }
        else {
            textField.layer.borderColor =  Appearance.TextField.Invalid.borderColor
            textField.layer.add(Appearance.TextField.Invalid.animation, forKey: "shake")
        }
    }
    
    static func buttonApplyAppereance(button: UIButton, isValid: Bool) {
        
        button.setBackgroundColor(Appearance.Button.Normal.backgroundColor, for: .normal)
        button.setBackgroundColor(Appearance.Button.Selected.backgroundColor, for: .selected)
        button.setBackgroundColor(Appearance.Button.Disabled.backgroundColor, for: .disabled)
        
        button.setTitleColor(Appearance.Button.Normal.titleColor, for: .normal)
        button.layer.cornerRadius = Appearance.Button.cornerRadius
        button.clipsToBounds = true
        
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
}
