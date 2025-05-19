//
//  UserInfoCard.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 18.04.2025.
//

import Foundation
import UIKit


enum UserInfoCardStyle {
    
    case primary

    public var shadowRadius: CGFloat  {
        return 4.0
    }

    public var cornerRadius: CGFloat  {
        return 12
    }

    public var shadowColor : CGColor {
        return UIColor.black.cgColor
    }
    
    public var shadowOpacity : Float {
        return 0.05
    }
    
    public var shadowOffset : CGSize {
        return CGSize(width: 0, height: 2)
    }
    
    public var backgroundColor : UIColor {
        return UIColor.appGrayBackground
    }
}
