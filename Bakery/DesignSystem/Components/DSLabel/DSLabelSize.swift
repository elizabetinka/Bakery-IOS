//
//  DSLabelSize.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 03.05.2025.
//

import CoreFoundation
import UIKit

enum DSLabelSize {
    case s
    case m
    case l

    func font(for style: DSLabelStyle) -> UIFont {
        switch (self,style) {
        case (.s, .primary): return UIFont.systemFont(ofSize: 14, weight: .regular)
        case (.m, .primary): return UIFont.systemFont(ofSize: 17, weight: .medium)
        case (.l, .primary): return UIFont.systemFont(ofSize: 30, weight: .bold)
        case (.s, .neutral): return UIFont.systemFont(ofSize: 14, weight: .regular)
        case (.m, .neutral): return UIFont.systemFont(ofSize: 14, weight: .medium)
        case (.l, .neutral): return UIFont.systemFont(ofSize: 16, weight: .bold)
        case (.s, .error): return UIFont.systemFont(ofSize: 12, weight: .regular)
        case (.m, .error): return UIFont.systemFont(ofSize: 14, weight: .medium)
        case (.l, .error): return UIFont.systemFont(ofSize: 17, weight: .bold)
        }
    }
}
