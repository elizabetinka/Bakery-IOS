//
//  StringExtension.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 17.04.2025.
//

import Foundation

extension String {
    func isValidPhone(_ pattern: String) -> Bool {
            guard let regex = try? NSRegularExpression(
                pattern: pattern,
                options: [.anchorsMatchLines]
            ) else { return false }
            
            let range = NSRange(startIndex..<endIndex, in: self)
            return regex.firstMatch(in: self, options: [], range: range) != nil
        }
}
