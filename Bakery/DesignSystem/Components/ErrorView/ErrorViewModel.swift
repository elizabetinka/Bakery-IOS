//
//  ErrorViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 30.04.2025.
//

struct ErrorViewModel: DSViewModel {
    let componentType: ComponentType = .errorView
    var identifier: String = "errorView"
    
    var title: DSLabelViewModel?
    var refreshButton: DSButtonViewModel?
    var state: ErrorViewState = .hidden
    
    var style: ErrorViewStyle = .init()
    var layout: DSLayout = .init()
}
