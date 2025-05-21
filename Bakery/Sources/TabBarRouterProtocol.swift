//
//  File.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 09.04.2025.
//

import Foundation
import UIKit

enum MyViewController{
    case home
    case user
    case menu
    case authentification
    case registration
    case itemDetails(itemId: UniqueIdentifier)
    case universal(config: UniversalScreenConfig)
    case someUniversalImplement
}

@MainActor
protocol TabBarRouterProtocol  : AnyObject {
    var tabBarController: UITabBarController { get }
    func start()
    func registerHandlers()
    func openViewController(toView : MyViewController)
}
