//
//  DSLabelViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 03.05.2025.
//

extension DSLabelViewModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifier, text, style, size, state, layout
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try container.decode(String.self, forKey: .identifier)
        text = try container.decode(String.self, forKey: .text)
        style = try container.decode(DSLabelStyle.self, forKey: .style)
        size = try container.decode(DSLabelSize.self, forKey: .size)
        state = try container.decode(DSLabelState.self, forKey: .state)
        layout = try container.decode(DSLayout.self, forKey: .layout)
    }
}

extension DSLabelStyle: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "primary": self = .primary
        case "neutral": self = .neutral
        case "beautyful": self = .beautyful
        case "commonEnumeration": self = .commonEnumeration
        case "error": self = .error
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid label style"
        )
        }
    }
}

extension DSLabelSize: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "s": self = .s
        case "m": self = .m
        case "l": self = .l
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid label size"
        )
        }
    }
}

extension DSLabelState: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "default": self = .default
        case "hidden": self = .hidden
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid label state"
        )
        }
    }
}
