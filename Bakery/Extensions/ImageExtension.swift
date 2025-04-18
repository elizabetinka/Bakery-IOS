//
//  ImageExtension.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 17.04.2025.
//

import UIKit

extension UIImage {
    /// Создаёт UIImage сплошного цвета заданного размера (по умолчанию 1×1 pt)
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        self.init(cgImage: cgImage)
    }
}
