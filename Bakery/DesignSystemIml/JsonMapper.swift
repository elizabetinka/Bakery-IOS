//
//  Untitled.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 18.05.2025.
//

import Foundation
import UIKit


enum JsonError: Error {
    case decodeFailed(underlyingError: Error)
}

protocol JsonMapper {
    static func map(jsonData: Data) -> (DSViewModel?,JsonError?)
}

final class JsonMapperImpl : JsonMapper {
    static func map(jsonData: Data) -> (DSViewModel?,JsonError?) {
        let decoder = JSONDecoder()
        do {
            let wrapper = try decoder.decode(DSViewModelWrapper.self, from: jsonData)
            let viewModel = wrapper.viewModel
            return (viewModel,nil)
        }
        catch {
            print("Error parsing JSON: \(error)")
            return (nil, .decodeFailed(underlyingError: error))
        }
    }
}

struct DSViewModelWrapper: Decodable {
    let viewModel: DSViewModel
    
    private enum CodingKeys: String, CodingKey {
        case componentType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let componentType = try container.decode(ComponentType.self, forKey: .componentType)
        
        switch componentType {
        case .button:
            viewModel = try DSButtonViewModel(from: decoder)
        case .label:
            viewModel = try DSLabelViewModel(from: decoder)
        case .text:
            viewModel = try DSTextFieldViewModel(from: decoder)
        case .activityIndicator:
            viewModel = try DSActivityIndicatorViewModel(from: decoder)
        case .image:
            viewModel = try DSImageViewModel(from: decoder)
        case .errorView:
            viewModel = try ErrorViewModel(from: decoder)
        case .spacer:
            viewModel = try DSSpacerViewModel(from: decoder)
        case .stack:
            viewModel = try DSStackViewModel(from: decoder)
        case .container:
            viewModel = try DSContainerViewModel(from: decoder)
        case .userInfoCard:
            viewModel = try UserInfoCardModelViewModel(from: decoder)
        case .commonCard:
            viewModel = try CommonCardViewModel(from: decoder)
        }
    }
}
