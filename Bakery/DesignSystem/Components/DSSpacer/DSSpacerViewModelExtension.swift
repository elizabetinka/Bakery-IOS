//
//  DSLabelViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 03.05.2025.
//

import CoreFoundation

extension DSSpacerViewModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifier,minHeight, layout
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try container.decode(String.self, forKey: .identifier)

        minHeight = try container.decode(CGFloat.self, forKey: .minHeight)
        layout = try container.decode(DSLayout.self, forKey: .layout)
    }
}
