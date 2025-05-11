//
//  DSStackViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 08.05.2025.
//

struct DSContainerViewModel: DSViewModel {
    let componentType: ComponentType = .container
    var identifier: String = "container"

    var layout: DSLayout = .init()
    var items: [DSViewModel] = []
    
    var topView: Int = 0
    var bottomView: Int =  0
}
