//
//  DSLabelViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 03.05.2025.
//

extension UserInfoCardModelViewModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifier, valueLabel,headerStack, style, layout
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try container.decode(String.self, forKey: .identifier)
        valueLabel = try container.decode(DSLabelViewModel.self, forKey: .valueLabel)
        style = try container.decode(UserInfoCardStyle.self, forKey: .style)
        headerStack = try container.decode(DSStackViewModel.self, forKey: .headerStack)
        layout = try container.decode(DSLayout.self, forKey: .layout)
    }
}

extension UserInfoCardStyle: Decodable {
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
