//
//  DSButtonSuze.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 29.04.2025.
//

import Foundation
import UIKit

enum DSButtonSize {
    case small
    case medium

    var height: CGFloat {
        switch self {
        case .small: return 32
        case .medium: return 40
        }
    }

    var font: UIFont {
        switch self {
        case .small: return UIFont.systemFont(ofSize: 14, weight: .medium)
        case .medium: return UIFont.systemFont(ofSize: 16, weight: .medium)
        }
    }

    var cornerRadius: CGFloat {
        return 8
    }
}
