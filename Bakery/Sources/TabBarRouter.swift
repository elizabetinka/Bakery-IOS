//
//  File.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 09.04.2025.
//

import Foundation
import UIKit

extension TabBarRouter {
    struct LocalAppearance {
        static let tabBarBackgroundColor=UIColor.appPink
        static let activeTintColor: UIColor = .white
        static let inactiveTintColor: UIColor = .appPink
        
    }
    
    func applyApperance() {
        Appearance.mainViewApplyAppereance(view: tabBarController.view)
        tabBarController.tabBar.tintColor = LocalAppearance.activeTintColor
        tabBarController.tabBar.barTintColor = LocalAppearance.inactiveTintColor
        tabBarController.tabBar.backgroundColor = LocalAppearance.tabBarBackgroundColor
    }
}

@MainActor
class TabBarRouter: TabBarRouterProtocol {
    
    func openViewController(toView: MyViewController) {
        print("openViewController \(toView)")
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
            openRegistration()
        case let .itemDetails(itemId):
            openItemDetails(itemId: itemId)
        }
        
    }
    
    
    let tabBarController: UITabBarController

    init() {
        self.tabBarController = UITabBarController()
    }
    
    func start() {

        let mainVC = CommonBuilder().set(router: self).build()
        if let routerApperance = mainVC as? CommonRouterAppearance {
            routerApperance.applyRouterSettigs()
        }
    
        
        let menuVC = MenuBuilder().set(router: self).build()
        if let routerApperance = menuVC as? MenuRouterAppearance {
            routerApperance.applyRouterSettigs()
        }
        
        let userVC = UserBuilder().set(router: self).build()
        if let routerApperance = userVC as? UserRouterAppearance {
            routerApperance.applyRouterSettigs()
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        
                    
        let mainNavController = UINavigationController(rootViewController: mainVC)
        mainNavController.setNavigationBarHidden(true, animated: false)
        
        let menuNavController = UINavigationController(rootViewController: menuVC)
        menuNavController.navigationBar.standardAppearance = appearance
        menuNavController.navigationBar.scrollEdgeAppearance = appearance
        
        let userNavController = UINavigationController(rootViewController: userVC)
        userNavController.navigationBar.standardAppearance = appearance
        userNavController.navigationBar.scrollEdgeAppearance = appearance
        
        tabBarController.viewControllers = [mainNavController, menuNavController, userNavController]
        applyApperance()
    }
    
    func selectTab(at index: Int) {
        guard let controllers = tabBarController.viewControllers, index < controllers.count else {
            return
        }
        tabBarController.selectedIndex = index
    }
        
        func openAutentification(){
            openViewController(toView: .home)
            let authController = UserAutentificationBuilder().set(router: self).build()
            authController.modalPresentationStyle = .overFullScreen // Это позволяет экрану накладываться поверх текущего
            authController.modalTransitionStyle = .coverVertical

            if let sheet = authController.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
            }
            
            authController.modalPresentationStyle = .pageSheet
            
            tabBarController.present(authController, animated: true, completion: nil)
        }
    
    func openRegistration(){
        openViewController(toView: .home)
        let regController = UserRegistrationBuilder().set(router: self).build()
        regController.modalPresentationStyle = .overFullScreen
        regController.modalTransitionStyle = .coverVertical
       
        if let sheet = regController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        regController.modalPresentationStyle = .pageSheet
        
        tabBarController.present(regController, animated: true, completion: nil)
    }
    
    func openItemDetails(itemId: UniqueIdentifier){
        let detailsVC = MenuDetailsBuilder().set(initialState: MenuDetails.ViewControllerState.initial(id: itemId)).set(router: self).build()
        
        if let routerApperance = detailsVC as? MenuDetailsRouterAppearance {
            routerApperance.applyRouterSettigs()
        }

        if let curViewController = tabBarController.viewControllers?[tabBarController.selectedIndex] {
            curViewController.present(detailsVC, animated: true)
        }
    }

}
