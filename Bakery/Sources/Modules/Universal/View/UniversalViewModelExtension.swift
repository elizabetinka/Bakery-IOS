//
//  UniversalViewModelExtension.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 21.05.2025.
//

extension UniversalViewModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case components, style
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let style = try container.decodeIfPresent(UniversalViewStyle.self, forKey: .style)
        self.style = style ?? self.style

        let decodedItems = try container.decode([DSViewModelWrapper].self, forKey: .components)
        components = decodedItems.map { $0.viewModel }
    }
}

extension UniversalViewStyle: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "primary": self = .primary
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid UniversalViewStyle"
        )
        }
    }
}
