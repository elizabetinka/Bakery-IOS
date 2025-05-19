//
//  DSButtonViewModelExtension.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 18.05.2025.
//


extension DSTextFieldViewModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifier, text, placeholder, style, size, state, layout, errorLabel, action
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try container.decode(String.self, forKey: .identifier)
        text = try container.decode(String.self, forKey: .text)
        placeholder = try container.decode(String.self, forKey: .placeholder)
        style = try container.decode(DSTextFieldStyle.self, forKey: .style)
        size = try container.decode(DSTextFieldSize.self, forKey: .size)
        state = try container.decode(DSTextFieldState.self, forKey: .state)
        layout = try container.decode(DSLayout.self, forKey: .layout)
        errorLabel = try container.decode(DSLabelViewModel.self, forKey: .errorLabel)
        
        if let action = try container.decodeIfPresent(HandlerModel.self, forKey: .action) {
            if let handler = ActionHandler<String>.shared().getHandler(action: action) {
                onEditingChanged = handler
            }
            }
    }
    
}

extension DSTextFieldStyle: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "default": self = .default
        case "placeholder": self = .placeholder
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid textField style"
        )
        }
    }
}

extension DSTextFieldSize: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "medium": self = .medium
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid textField size"
        )
        }
    }
}

extension DSTextFieldState: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "default": self = .default
        case "error": self = .error
        case "disabled": self = .disabled
        case "hidden": self = .hidden
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid textField state"
        )
        }
    }
}
