//
//  UiViewFinder.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 09.05.2025.
//

import UIKit

extension UIView {
    func findView(withAccessibilityIdentifier identifier: String) -> UIView? {
        if self.accessibilityIdentifier == identifier {
            return self
        }
        for subview in self.subviews {
            if let match = subview.findView(withAccessibilityIdentifier: identifier) {
                return match
            }
        }
        return nil
    }
}
