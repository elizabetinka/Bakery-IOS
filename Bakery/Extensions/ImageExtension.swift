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
    
    func scaled(by factor: CGFloat) -> UIImage? {
            let newWidth = self.size.width / factor
            let newHeight = self.size.height / factor
            let newSize = CGSize(width: newWidth, height: newHeight)
            
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            defer { UIGraphicsEndImageContext() }
            
            self.draw(in: CGRect(origin: .zero, size: newSize))
            return UIGraphicsGetImageFromCurrentImageContext()
        }
}
