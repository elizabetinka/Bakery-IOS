//
//  DSButtonStyle.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 29.04.2025.
//

import UIKit

enum DSButtonStyle {
    case primary
    case neutral
    case subtle

    func backgroundColor(for state: DSButtonState) -> UIColor {
            switch (self, state) {
            case (.primary, .default): return UIColor.appSoftBlue
            case (.primary, .hover): return UIColor.appBlue
            case (.primary, .disabled): return UIColor.appDisabled
            case (.neutral, .default): return UIColor.appSoftGray
            case (.neutral, .hover): return UIColor.appDarkGray
            case (.neutral, .disabled): return UIColor.appDisabled
            case (.subtle, .default): return UIColor.white
            case (.subtle, .hover): return UIColor.white
            case (.subtle, .disabled): return UIColor.appDisabled
            default: return UIColor.clear
    }
    }
    
    func textColor(for state: DSButtonState) -> UIColor {
        switch (self, state) {
        case (.primary, .default): return UIColor.white
        case (.primary, .hover): return UIColor.white
        case (.primary, .disabled): return UIColor.appDisabledLabel
        case (.neutral, .default): return UIColor.appBlue
        case (.neutral, .hover): return UIColor.appBlue
        case (.neutral, .disabled): return UIColor.appDisabledLabel
        case (.subtle, .default): return  UIColor.gray
        case (.subtle, .hover): return UIColor.black
        case (.subtle, .disabled): return UIColor.appDisabledLabel
        default: return UIColor.clear
        }
    }
    
    public var clipsToBounds : Bool {
        return true
    }

}
