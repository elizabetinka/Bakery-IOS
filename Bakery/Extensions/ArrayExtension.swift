//
//  ArrayExtension.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 15.04.2025.
//

import Foundation


extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
