//
//  DSViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 08.05.2025.
//

protocol DSViewModel {
    var componentType: ComponentType { get }
    var layout: DSLayout {get}
    var identifier: String {get}
}

enum ComponentType {
    case button
    case label
    case text
    case image
    case activityIndicator
    case errorView
    case container
    case stack
    case spacer
    case userInfoCard
    case commonCard
}

extension ComponentType: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "button": self = .button
        case "label": self = .label
        case "text": self = .text
        case "image": self = .image
        case "activityIndicator": self = .activityIndicator
        case "errorView": self = .errorView
        case "container": self = .container
        case "stack": self = .stack
        case "spacer": self = .spacer
        case "userInfoCard": self = .userInfoCard
        case "commonCard": self = .commonCard
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid component type"
        )
        }
    }
}
