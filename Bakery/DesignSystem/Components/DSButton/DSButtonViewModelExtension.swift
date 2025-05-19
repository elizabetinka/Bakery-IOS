//
//  DSButtonViewModelExtension.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 18.05.2025.
//


extension DSButtonViewModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifier, title, style, size, state, layout, action
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try container.decode(String.self, forKey: .identifier)
        title = try container.decode(String.self, forKey: .title)
        style = try container.decode(DSButtonStyle.self, forKey: .style)
        size = try container.decode(DSButtonSize.self, forKey: .size)
        state = try container.decode(DSButtonState.self, forKey: .state)
        layout = try container.decode(DSLayout.self, forKey: .layout)
        
        if let action = try container.decodeIfPresent(HandlerModel.self, forKey: .action) {
            
            if let handler = ActionHandler<Void>.shared().getHandler(action: action) {
                onTap = handler
            }

            }
    }
}

extension DSButtonStyle: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "primary": self = .primary
        case "neutral": self = .neutral
        case "subtle": self = .subtle
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid button style"
        )
        }
    }
}

extension DSButtonSize: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "small": self = .small
        case "medium": self = .medium
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid button size"
        )
        }
    }
}

extension DSButtonState: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "default": self = .default
        case "hover": self = .hover
        case "disabled": self = .disabled
        case "hidden": self = .hidden
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid button state"
        )
        }
    }
}
