//
//  ButtonExtension.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 17.04.2025.
//

import UIKit

extension UIButton {
    /// Устанавливает фон из цвета для указанного состояния
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let image = UIImage(color: color)
        setBackgroundImage(image, for: state)
    }
}
