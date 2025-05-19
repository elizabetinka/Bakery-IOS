//
//  DSStackSize.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 08.05.2025.
//

import CoreFoundation

enum DSStackSize {
    case s
    case m
    case l

    func spacing(for style: DSStackStyle) -> CGFloat {
        switch (self,style) {
        case (.s, .horizontal): return HSpacing.s.rawValue
        case (.s, .vertical): return VSpacing.s.rawValue
        case (.m, .horizontal): return HSpacing.m.rawValue
        case (.m, .vertical): return VSpacing.m.rawValue
        case (.l, .horizontal): return HSpacing.l.rawValue
        case (.l, .vertical): return VSpacing.l.rawValue
        }
    }
}
