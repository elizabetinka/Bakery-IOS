//
//  DSLabelStyle.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 03.05.2025.
//

import UIKit

enum DSLabelStyle {
    case primary
    case neutral
    case error
    
    func textColor() -> UIColor {
        switch (self) {
        case (.primary): return UIColor.gray
        case (.neutral): return UIColor.black
        case (.error): return  UIColor.appError
        }
    }
    
    public var numberOfLines : Int {
        return 0
    }
    
    public var lineBreakMode: NSLineBreakMode {
        return NSLineBreakMode.byWordWrapping
    }
    
    public var adjustsFontSizeToFitWidth : Bool {
        return false
    }
    
    func textAlignment(for style: DSLabelStyle) -> NSTextAlignment {
        switch (style) {
            case (.error): return NSTextAlignment.left
            default : return NSTextAlignment.center
        }
    }

}
