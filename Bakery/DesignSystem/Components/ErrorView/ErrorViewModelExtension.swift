//
//  DSLabelViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 03.05.2025.
//

extension ErrorViewModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifier, title, style, button, state, layout
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try container.decode(String.self, forKey: .identifier)
        title = try container.decode(DSLabelViewModel.self, forKey: .title)
        style = try container.decode(ErrorViewStyle.self, forKey: .style)
        refreshButton = try container.decode(DSButtonViewModel.self, forKey: .button)
        state = try container.decode(ErrorViewState.self, forKey: .state)
        layout = try container.decode(DSLayout.self, forKey: .layout)
    }
}

extension ErrorViewStyle: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "primary": self = .primary
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid ErrorView style"
        )
        }
    }
}


extension ErrorViewState: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "error": self = .error
        case "hidden": self = .hidden
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid ErrorView state"
        )
        }
    }
}
