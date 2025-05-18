//
//  DSTextFieldStyle.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 30.04.2025.
//

import UIKit

public enum DSTextFieldStyle {

    case `default`
    case placeholder

    public func backgroundColor(for state: DSTextFieldState) -> UIColor {
        switch (self, state) {
        case (.default, .default):      return UIColor.appGrayTextFieldBackground
        case (.default, .disabled):     return UIColor.appDisabled
        case (.default, .error):        return UIColor.appGrayTextFieldBackground
        case (.placeholder, .default):  return UIColor.appGrayTextFieldBackground.withAlphaComponent(0.5)
        case (.placeholder, .disabled): return UIColor.appDisabled
        case (.placeholder, .error):    return UIColor.appGrayTextFieldBackground.withAlphaComponent(0.5)
        case (_, .hidden):              return UIColor.clear
        }
    }

    public func borderColor(for state: DSTextFieldState) -> CGColor {
        switch (self, state) {
        case (_, .disabled):      return UIColor.appGrayTextFieldBackground.cgColor
        case (_, .error):         return UIColor.appError.cgColor
        default:                  return UIColor.clear.cgColor
        }
    }

    public func borderWidth(for state: DSTextFieldState) -> CGFloat {
        switch state {
        case .default: return 0
        default:       return 1
        }
    }
    
    public var borderStyle: UITextField.BorderStyle {
        return UITextField.BorderStyle.roundedRect
    }

    public func textColor(for state: DSTextFieldState) -> UIColor {
        switch (self, state) {
        case (.default, .default):      return UIColor.black
        case (.default, .disabled):     return UIColor.appDisabledLabel
        case (.default, .error):        return UIColor.black
        case (.placeholder, .default):  return UIColor.white
        case (.placeholder, .disabled): return UIColor.appDisabledLabel
        case (.placeholder, .error):    return UIColor.white
        case (_, .hidden):              return UIColor.clear
            
        }
    }
    
    func animation(for state: DSTextFieldState) -> CAKeyframeAnimation? {
        
        let _ : CAKeyframeAnimation = {
            let animation = CAKeyframeAnimation(keyPath: "position.x")
            animation.values = [0, 10, -10, 10, 0]
            animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
            animation.duration = 0.4
            animation.isAdditive = true
            return animation
        }()
        
        switch (state) {
        case (.error): return nil
        default: return nil
        }
    }
    
    public var font: UIFont { UIFont.systemFont(ofSize: 16) }
    public var keyboardType: UIKeyboardType { UIKeyboardType.namePhonePad }
}
