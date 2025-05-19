//
//  DSLabelViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 03.05.2025.
//

import UIKit

struct ImageModel: Decodable {
    let imageBase64: String
}

extension DSImageViewModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifier, imageBase64, size, layout
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try container.decode(String.self, forKey: .identifier)
        let imageBase64 = try container.decode(String.self, forKey: .imageBase64)
        if let data = Data(base64Encoded: imageBase64) {
            let ui_image = UIImage(data: data)
            image = ui_image
        }

        size = try container.decode(DSImageSize.self, forKey: .size)
        layout = try container.decode(DSLayout.self, forKey: .layout)
    }
}


extension DSImageSize: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "default": self = .default
        case "icon": self = .icon
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid label size"
        )
        }
    }
}

