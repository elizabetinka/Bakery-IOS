//
//  CommonCardSize.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 10.05.2025.
//

import CoreFoundation

enum CommonCardSize {
    case small
    case medium

    var height: CGFloat {
        switch self {
        case .small: return 120
        case .medium: return 170
        }
    }
}
