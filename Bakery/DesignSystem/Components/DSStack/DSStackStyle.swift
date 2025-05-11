//
//  DSStackStyle.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 08.05.2025.
//

import UIKit

enum DSStackStyle {
    case vertical
    case horizontal
    
    public var axis : NSLayoutConstraint.Axis {
        switch (self) {
        case .horizontal: return NSLayoutConstraint.Axis.horizontal
        case .vertical: return NSLayoutConstraint.Axis.vertical
        }
    }
    
    public var spacing : CGFloat {
        switch (self) {
        case .horizontal: return 8
        case .vertical: return 8
        }
    }
}
