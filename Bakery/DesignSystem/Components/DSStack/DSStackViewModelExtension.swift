//
//  DSButtonViewModelExtension.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 18.05.2025.
//


extension DSStackViewModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifier, style, size, alignment, layout, items
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try container.decode(String.self, forKey: .identifier)
        alignment = try container.decode(DSStackAlignment.self, forKey: .alignment)
        style = try container.decode(DSStackStyle.self, forKey: .style)
        size = try container.decode(DSStackSize.self, forKey: .size)
        layout = try container.decode(DSLayout.self, forKey: .layout)
        let decodedItems = try container.decode([DSViewModelWrapper].self, forKey: .items)
        items = decodedItems.map { $0.viewModel }

            }
    }
    
extension DSStackStyle: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "vertical": self = .vertical
        case "horizontal": self = .horizontal
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid DSStack style"
        )
        }
    }
}

extension DSStackSize: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "s": self = .s
        case "m": self = .m
        case "l": self = .l
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid DSStack  size"
        )
        }
    }
}

extension DSStackAlignment: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "center": self = .center
        case "equal": self = .equal
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid DSStack state"
        )
        }
    }
}
