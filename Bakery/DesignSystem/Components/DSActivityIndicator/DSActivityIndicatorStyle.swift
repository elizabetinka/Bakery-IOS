//
//  DSActivityIndicatorStyle.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 06.05.2025.
//

import UIKit

enum DSActivityIndicatorStyle {
    case primary
    
    public var hidesWhenStopped : Bool {
        return true
    }
    
    public var color : UIColor {
        return UIColor.gray
    }
    

}
