//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

protocol CommonProviderProtocol {
    func getRandomItem() async -> (ItemModel?, CommonItemProviderError?)
    func getCurrentUserInfo() async -> (UserModel?, CommonUserProviderError?)
}

enum CommonItemProviderError: Error {
    case getItemFailed(underlyingError: Error)
    case emptyData
    case unknown
}

enum CommonUserProviderError: Error {
    case getUserFailed(underlyingError: Error)
    case notAuthorized
    case unknown
}

/// Отвечает за получение данных модуля Common
struct CommonProvider: CommonProviderProtocol {
    
    let menuDataStore: MenuDataStoreProtocol
    let userDataStore: UserDataStoreProtocol
    let menuService: MenuServiceProtocol
    let userService: UserServiceProtocol
    let sessionService: UserSessionServiceProtocol

    init(menuDataStore: MenuDataStoreProtocol = MenuDataStore.shared,userDataStore: UserDataStoreProtocol = UserDataStore.shared, menuService: MenuServiceProtocol = MenuService.shared, userService: UserServiceProtocol = UserService.shared, sessionService: UserSessionServiceProtocol = UserSessionService.shared) {
        
        self.userDataStore = userDataStore
        self.menuDataStore = menuDataStore
        self.menuService = menuService
        self.sessionService = sessionService
        self.userService = userService
    }
    
    func getCurrentUserInfo() async -> (UserModel?, CommonUserProviderError?){
        guard let id = self.sessionService.getCurrentUserId() else {
            return (nil, .notAuthorized)
        }
        
        if let info = userDataStore.fetchUser(by: id) {
            return (info, nil)
        }
        
        let (info, error) = await userService.fetchUser(by: id )
        
        if let error = error {
            switch error {
            case .notExists:
                return (nil, .notAuthorized)
            default:
                return (nil, .getUserFailed(underlyingError: error))
            }
        } else if let model = info {
            userDataStore.addUser(model)
            return (model, nil)
        }
        else{
            return (nil, .unknown)
        }
    }

    func getRandomItem() async -> (ItemModel?, CommonItemProviderError?) {
        let cashedItems = menuDataStore.fetchItems()
        if cashedItems.isEmpty == false {
            return (cashedItems[0], nil)
        }
        
        let (items, error) = await menuService.fetchItems()
        
        if let error = error {
            return (nil, .getItemFailed(underlyingError: error))
        } else if let images = items {
            if images.isEmpty == false {
                menuDataStore.saveItems(images)
                return (images[0], nil)
            }
            else{
                return (nil, .emptyData)
            }
        }
        else {
            return (nil, .unknown)
        }
    }
}
