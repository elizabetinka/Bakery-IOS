//
//  Spacing.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 29.04.2025.
//
import Foundation


enum HSpacing: CGFloat {
    case zero = 0
    case xs   = 4
    case s    = 8
    case m    = 16
    case l    = 24
    case xl   = 50
}

enum VSpacing: CGFloat {
    case zero = 0
    case xs   = 8
    case s    = 16
    case m    = 32
    case l    = 48
    case xl   = 70
    case xxl  = 150
}

enum DSWidth {
    case `auto`
    case fill
    case fixed(CGFloat)
}

enum DSHeight {
    case `auto`
    case fixed(CGFloat)
}

enum DSAlign {
    case `auto`
    case center
}
