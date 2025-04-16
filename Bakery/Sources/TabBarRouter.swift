//
//  File.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 09.04.2025.
//

import Foundation
import UIKit

extension TabBarRouter {
    struct Appearance {
        let backgroundColor=UIColor.white
    }
    
    func applyApperance() {
        let appearance = Appearance()
        tabBarController.view.backgroundColor = appearance.backgroundColor
    }
}

class TabBarRouter: TabBarRouterProtocol {
    
    func openViewController(toView: MyViewController) {
        switch toView {
        case .home:
            selectTab(at: 0)
        case .user:
            selectTab(at: 2)
        case .menu:
            selectTab(at: 1)
        case.authentification:
            openAutentification()
        case .registration:
            selectTab(at: 0)
        case let .itemDetails(itemId):
            openItemDetails(itemId: itemId)
        }
        
    }
    
    
    let tabBarController: UITabBarController
    lazy var authController = UserAutentificationBuilder().build()

    init() {
        self.tabBarController = UITabBarController()
        applyApperance()
    }
    
    func start() {

        let mainVC = CommonBuilder().build()
        if let routerApperance = mainVC as? CommonRouterAppearance {
            routerApperance.applyRouterSettigs()
        }
        
        let menuVC = MenuBuilder().build()
        if let routerApperance = menuVC as? MenuRouterAppearance {
            routerApperance.applyRouterSettigs()
        }
        
        let userVC = UserBuilder().build()
        if let routerApperance = userVC as? UserRouterAppearance {
            routerApperance.applyRouterSettigs()
        }
        
        let mainNavController = UINavigationController(rootViewController: mainVC)
        let menuNavController = UINavigationController(rootViewController: menuVC)
        let userNavController = UINavigationController(rootViewController: userVC)
        
        tabBarController.viewControllers = [mainNavController, menuNavController, userNavController]
    }
    
    func selectTab(at index: Int) {
        guard let controllers = tabBarController.viewControllers, index < controllers.count else {
            return
        }
        tabBarController.selectedIndex = index
    }
        
        func openAutentification(){
            authController.modalPresentationStyle = .overFullScreen // Это позволяет экрану накладываться поверх текущего
            authController.modalTransitionStyle = .coverVertical
            if let curViewController = tabBarController.viewControllers?[tabBarController.selectedIndex] {
                curViewController.present(authController, animated: true, completion: nil)
            }
        }
    
    func openItemDetails(itemId: UniqueIdentifier){
        let detailsVC = MenuDetailsBuilder().set(initialState: MenuDetails.ViewControllerState.initial(id: itemId)).build()
        
        if let routerApperance = detailsVC as? MenuDetailsRouterAppearance {
            routerApperance.applyRouterSettigs()
        }

        if let curViewController = tabBarController.viewControllers?[tabBarController.selectedIndex] {
            curViewController.present(detailsVC, animated: true)
        }
    }

}
