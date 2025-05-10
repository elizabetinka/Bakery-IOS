//
//  DSSpacerViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 09.05.2025.
//

import CoreFoundation

struct DSSpacerViewModel: DSViewModel {
    let componentType: ComponentType = .spacer
    var identifier: String = "spacer"

    var layout: DSLayout = .init()
    var minHeight: CGFloat = 0
}
