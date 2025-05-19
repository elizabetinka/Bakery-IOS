//
//  UserInfoCard.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 18.04.2025.
//

import Foundation
import UIKit


enum ErrorViewStyle {
    
    case primary

    public var borderWidth: CGFloat  {
        return 4.0
    }
    
    public var cornerRadius: CGFloat  {
        return 15
    }

    public var borderColor : CGColor {
        return UIColor.appSoftPink.cgColor
    }
    
    public var backgroundColor : UIColor {
        return UIColor.white
    }
}
