//
//  DSStackViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 08.05.2025.
//

struct DSStackViewModel: DSViewModel {
    var identifier: String = "stack"
    let componentType: ComponentType = .stack
    
    var style: DSStackStyle
    var size: DSStackSize
    var alignment: DSStackAlignment
    var layout: DSLayout
    var items: [DSViewModel]
}
