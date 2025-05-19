//
//  DSImageSize.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 06.05.2025.
//

import CoreFoundation

enum DSImageSize {
    case `default`
    case icon

    var height: CGFloat {
        switch self {
        case .default:
            return 170
        case .icon:
            return 50
        }
    }
    
    var width: CGFloat {
        switch self {
        case .default:
            return 200
        case .icon:
            return 50
        }
    }
}
