//
//  DSLabelViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 03.05.2025.
//

extension DSActivityIndicatorViewModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifier,style, size, state, layout
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try container.decode(String.self, forKey: .identifier)

        style = try container.decode(DSActivityIndicatorStyle.self, forKey: .style)
        size = try container.decode(DSActivityIndicatorSize.self, forKey: .size)
        state = try container.decode(DSActivityIndicatorState.self, forKey: .state)
        layout = try container.decode(DSLayout.self, forKey: .layout)
    }
}

extension DSActivityIndicatorStyle: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "primary": self = .primary
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid ActivityIndicator style"
        )
        }
    }
}

extension DSActivityIndicatorSize: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "large": self = .large
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid ActivityIndicator size"
        )
        }
    }
}

extension DSActivityIndicatorState: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "running": self = .running
        case "stopped": self = .stopped
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid ActivityIndicator state"
        )
        }
    }
}
