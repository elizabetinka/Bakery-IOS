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
    
    func registerHandlers(){
        ActionHandler<Void>.shared().registerHandler(for: HandlerModel(route: "home"), handler: {
            self.openViewController(toView: .home)
        })
        ActionHandler<Void>.shared().registerHandler(for: HandlerModel(route: "user"), handler: {
            self.openViewController(toView: .user)
        })
        ActionHandler<Void>.shared().registerHandler(for: HandlerModel(route: "menu"), handler: {
            self.openViewController(toView: .menu)
        })
        ActionHandler<Void>.shared().registerHandler(for: HandlerModel(route: "authentification"), handler: {
            self.openViewController(toView: .authentification)
        })
        ActionHandler<Void>.shared().registerHandler(for: HandlerModel(route: "registration"), handler: {
            self.openViewController(toView: .registration)
        })
        ActionHandler<Void>.shared().registerHandler(for: HandlerModel(route: "some-screen"), handler: {
            self.openViewController(toView: .someUniversalImplement)
        })
        ActionHandler<UniqueIdentifier>.shared().registerHandler(for: HandlerModel(custom: "itemDetails"), handler: {id in
            self.openViewController(toView: .itemDetails(itemId: id))
        })
        ActionHandler<UniversalScreenConfig>.shared().registerHandler(for: HandlerModel(custom: "universal"), handler: {config in
            self.openViewController(toView: .universal(config: config))
        })
    }
    
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
        case let .universal(config):
            openUniversal(config: config)
        case .someUniversalImplement:
            let config = UniversalScreenConfig(endpoint: "https://alfa-itmo.ru/server/v1/storage/", key: "some-screen")
            openUniversal(config: config)
            
        }
    }
    
    
    let tabBarController: UITabBarController
    var currentAnimatedController: UIViewController?

    init() {
        self.tabBarController = UITabBarController()
        registerHandlers()
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
        closeAnimatedController()
        tabBarController.selectedIndex = index
    }
    
    
    func openUniversal(config: UniversalScreenConfig){
        let uniController = UniversalBuilder().set(router: self).set(config: config).build()
        uniController.modalPresentationStyle = .overFullScreen
        uniController.modalTransitionStyle = .coverVertical

        if let sheet = uniController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        uniController.modalPresentationStyle = .pageSheet
        
        currentAnimatedController = uniController
        
        tabBarController.present(uniController, animated: true, completion: nil)
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
    
    private func closeAnimatedController(){
        currentAnimatedController?.dismiss(animated: true, completion: nil)
    }

}
