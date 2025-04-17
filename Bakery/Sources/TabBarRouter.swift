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
        let tabBarBackgroundColor=UIColor.appPink
        let activeTintColor: UIColor = .white
        let inactiveTintColor: UIColor = .appPink
        
    }
    
    func applyApperance() {
        let appearance = Appearance()
        
        
        lazy var tabBarAppearance: UITabBarAppearance = {
            let appearance = Appearance()
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = appearance.backgroundColor
            tabBarAppearance.stackedLayoutAppearance.selected.iconColor = appearance.activeTintColor
            tabBarAppearance.stackedLayoutAppearance.normal.iconColor = appearance.inactiveTintColor
            return tabBarAppearance
        }()
        
       
        tabBarController.view.backgroundColor = appearance.backgroundColor
        tabBarController.tabBar.tintColor = appearance.activeTintColor
        tabBarController.tabBar.barTintColor = appearance.inactiveTintColor
        tabBarController.tabBar.backgroundColor = appearance.tabBarBackgroundColor
        
//        tabBarController.tabBar.standardAppearance = tabBarAppearance
//        if #available(iOS 15.0, *) {
//            tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
//        }
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
        
        let mainNavController = UINavigationController(rootViewController: mainVC)
        let menuNavController = UINavigationController(rootViewController: menuVC)
        let userNavController = UINavigationController(rootViewController: userVC)
        
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
            print("open Autentification")
            //tabBarController.viewControllers?[tabBarController.selectedIndex].present(authController, animated: true, completion: nil)
            
            if let sheet = authController.sheetPresentationController {
                sheet.detents = [.medium(), .large()]  // или .custom(...) на iOS 16+
                sheet.prefersGrabberVisible = true     // показывает "граббер" наверху
            }
            // Важно указать стиль:
            authController.modalPresentationStyle = .pageSheet
            
            tabBarController.present(authController, animated: true, completion: nil)
        }
    
    func openRegistration(){
        openViewController(toView: .home)
        let regController = UserRegistrationBuilder().set(router: self).build()
        regController.modalPresentationStyle = .overFullScreen // Это позволяет экрану накладываться поверх текущего
        regController.modalTransitionStyle = .coverVertical
        print("open Registration")
        //tabBarController.viewControllers?[tabBarController.selectedIndex].present(authController, animated: true, completion: nil)
        
        if let sheet = regController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]  // или .custom(...) на iOS 16+
            sheet.prefersGrabberVisible = true     // показывает "граббер" наверху
        }
        // Важно указать стиль:
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
