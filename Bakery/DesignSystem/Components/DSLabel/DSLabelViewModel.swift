//
//  DSLabelViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 03.05.2025.
//

struct DSLabelViewModel: DSViewModel {
    let componentType: ComponentType = .label
    var identifier: String
    
    var text: String = ""
    var style: DSLabelStyle
    var state: DSLabelState
    var size: DSLabelSize
    var layout: DSLayout

    public init(
        identifier: String = "label",
        text: String = "",
        style: DSLabelStyle = .primary,
        state: DSLabelState = .default,
        size: DSLabelSize = .m,
        layout: DSLayout = .init()
    ) {
        self.identifier = identifier
        self.text = text
        self.style = style
        self.state = state
        self.size = size
        self.layout = layout
    }
}
