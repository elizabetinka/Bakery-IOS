//
//  CommonCardStyle.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 10.05.2025.
//

import UIKit

enum CommonCardStyle{ 
    case text
    case image
    
    func contentMode() -> UIView.ContentMode {
        switch (self) {
        case (.text): return .scaleToFill
        case (.image): return .scaleAspectFill
        }
    }
    
    var cornerRadius: CGFloat {
        return 8
    }
    
}
