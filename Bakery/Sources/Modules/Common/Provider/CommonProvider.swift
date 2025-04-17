//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

protocol CommonProviderProtocol {
    func getRandomItem(completion: @escaping (ItemModel?, CommonItemProviderError?) -> Void)
    func getCurrentUserInfo(completion: @escaping (UserModel?, CommonUserProviderError?) -> Void)
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
    
    func getCurrentUserInfo(completion: @escaping (UserModel?, CommonUserProviderError?) -> Void) {
        guard let id = self.sessionService.getCurrentUserId() else {
            return completion(nil, .notAuthorized)
        }
        
        if let info = userDataStore.fetchUser(by: id) {
            return completion(info, nil)
        }
        
        userService.fetchUser(by: id ) { (info, error) in
            if let error = error {
                switch error {
                case .notExists:
                    completion(nil, .notAuthorized)
                default:
                    completion(nil, .getUserFailed(underlyingError: error))
                }
            } else if let model = info {
                userDataStore.addUser(model)
                completion(model, nil)
            }
            else{
                completion(nil, .unknown)
            }
        }
        
        
    }

    func getRandomItem(completion: @escaping (ItemModel?, CommonItemProviderError?) -> Void) {
        let items = menuDataStore.fetchItems()
        if items.isEmpty == false {
            return completion(items[0], nil)
        }
        menuService.fetchItems { (items, error) in
            if let error = error {
                completion(nil, .getItemFailed(underlyingError: error))
                return
            } else if let images = items {
                if images.isEmpty == false {
                    menuDataStore.saveItems(images)
                    completion(images[0], nil)
                    return
                }
                completion(nil, .emptyData)
            }
            else {
                completion(nil, .unknown)
            }
        }
    }
}
