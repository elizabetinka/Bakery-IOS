//
//  ReuseId.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 20.04.2025.
//

import Foundation
import UIKit


protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableView {}
