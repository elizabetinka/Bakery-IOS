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
}
