//
//  DSTextFieldViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 30.04.2025.
//

struct DSTextFieldViewModel: DSViewModel {
    let componentType: ComponentType = .text
    var identifier: String = "textField"
    var text: String? = nil
    var placeholder: String = ""
    var style: DSTextFieldStyle
    var state: DSTextFieldState
    var size: DSTextFieldSize
    var onEditingChanged: ((String) -> Void)?
    var errorLabel: DSLabelViewModel
    var layout: DSLayout

    public init(
        placeholder: String,
        style: DSTextFieldStyle = .default,
        state: DSTextFieldState = .default,
        size: DSTextFieldSize = .medium,
        layout: DSLayout = .init(),
        onEditingChanged: ((String) -> Void)? = nil,
        errorLabel: DSLabelViewModel
    ) {
        self.placeholder = placeholder
        self.style = style
        self.state = state
        self.size = size
        self.onEditingChanged = onEditingChanged
        self.errorLabel = errorLabel
        self.layout = layout
    }
}
