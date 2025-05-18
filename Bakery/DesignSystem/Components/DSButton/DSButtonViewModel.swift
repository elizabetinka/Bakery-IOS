//
//  DSButtonViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 29.04.2025.
//

struct DSButtonViewModel: DSViewModel {
    let componentType: ComponentType = .button
    var identifier: String = "button"
    
    var title: String
    var style: DSButtonStyle
    var size: DSButtonSize
    var state: DSButtonState
    var layout: DSLayout
    var onTap: (() -> Void)?
}
