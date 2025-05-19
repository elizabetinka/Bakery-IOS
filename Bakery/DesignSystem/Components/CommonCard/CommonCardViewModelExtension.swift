//
//  DSButtonViewModelExtension.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 18.05.2025.
//

import Foundation
import UIKit


extension CommonCardViewModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifier, backroundImage, style, size, content, layout, action
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try container.decode(String.self, forKey: .identifier)
        content = try container.decode(DSContainerViewModel.self, forKey: .content)
        style = try container.decode(CommonCardStyle.self, forKey: .style)
        size = try container.decode(CommonCardSize.self, forKey: .size)
        
        let imageBase64 = try container.decode(String.self, forKey: .backroundImage)
        if let data = Data(base64Encoded: imageBase64) {
            let ui_image = UIImage(data: data)
            backroundImageView = ui_image
        }
        layout = try container.decode(DSLayout.self, forKey: .layout)
        
        if let action = try container.decodeIfPresent(HandlerModel.self, forKey: .action) {
            if let handler = ActionHandler<Void>.shared().getHandler(action: action) {
                onTap = handler
            }
            }
    }
}

extension CommonCardStyle: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "text": self = .text
        case "image": self = .image
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid CommonCard style"
        )
        }
    }
}

extension CommonCardSize: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "small": self = .small
        case "medium": self = .medium
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid CommonCard size"
        )
        }
    }
}
