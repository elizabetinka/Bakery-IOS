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
        case (.s, .commonEnumeration): return UIFont.systemFont(ofSize: 14, weight: .regular)
        case (.m, .commonEnumeration): return UIFont.systemFont(ofSize: 17, weight: .medium)
        case (.l, .commonEnumeration): return UIFont.systemFont(ofSize: 30, weight: .bold)
        case (.s, .neutral): return UIFont.systemFont(ofSize: 14, weight: .regular)
        case (.m, .neutral): return UIFont.systemFont(ofSize: 14, weight: .medium)
        case (.l, .neutral): return UIFont.systemFont(ofSize: 16, weight: .bold)
        case (.s, .error): return UIFont.systemFont(ofSize: 12, weight: .regular)
        case (.m, .error): return UIFont.systemFont(ofSize: 14, weight: .medium)
        case (.l, .error): return UIFont.systemFont(ofSize: 17, weight: .bold)
        case (.s, .beautyful): return UIFont(name: "Zapfino", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular)
        case (.m, .beautyful): return UIFont(name: "Zapfino", size: 20) ?? UIFont.systemFont(ofSize: 30, weight: .medium)
        case (.l, .beautyful): return UIFont(name: "Zapfino", size: 50) ?? UIFont.systemFont(ofSize: 50, weight: .bold)
        }
    }
}
