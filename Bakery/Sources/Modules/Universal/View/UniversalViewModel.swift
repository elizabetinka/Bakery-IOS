//
//  UniversalViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 30.04.2025.
//

struct UniversalViewModel {
    var components: [DSViewModel] = []
    var style: UniversalViewStyle = .primary
    var topComponent: Int = 0
    var bottomComponent: Int
    
    init(components: [DSViewModel] = [], style: UniversalViewStyle = .primary, topComponent: Int = 0) {
        self.components = components
        self.style = style
        self.topComponent = topComponent
        self.bottomComponent = components.count
    }
    
    init(components: [DSViewModel]=[], style: UniversalViewStyle = .primary, topComponent: Int = 0, bottomComponent: Int) {
        self.components = components
        self.style = style
        self.topComponent = topComponent
        self.bottomComponent = bottomComponent
    }
    
    init(components: [DSViewModel]=[], style: UniversalViewStyle?, topComponent: Int?, bottomComponent: Int?) {
        self.components = components
        self.style = style ?? .primary
        self.topComponent = topComponent ?? 0
        self.bottomComponent = bottomComponent ?? components.count
    }
}

