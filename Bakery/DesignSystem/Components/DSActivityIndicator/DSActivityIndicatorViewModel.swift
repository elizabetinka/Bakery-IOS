//
//  DSActivityIndicatorViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 06.05.2025.
//

struct DSActivityIndicatorViewModel: DSViewModel {
    let componentType: ComponentType = .activityIndicator
    var identifier: String = "activityIndicator"
    
    var state: DSActivityIndicatorState
    var size: DSActivityIndicatorSize
    var style: DSActivityIndicatorStyle
    var layout: DSLayout

    public init(
        state: DSActivityIndicatorState = .stopped,
        size: DSActivityIndicatorSize = .large,
        style: DSActivityIndicatorStyle = .primary,
        layout: DSLayout = .init()
    ) {
        self.state = state
        self.size = size
        self.style = style
        self.layout = layout
    }
}
