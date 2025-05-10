//
//  DSTextFieldSize.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 01.05.2025.
//

import CoreFoundation
import UIKit

enum DSTextFieldSize {
    case medium

    var height: CGFloat {
        return 40
    }

    var font: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .medium)
    }

    var cornerRadius: CGFloat {
        return 15
    }
}
