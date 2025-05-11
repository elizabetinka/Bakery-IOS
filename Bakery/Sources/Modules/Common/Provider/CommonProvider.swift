//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

protocol CommonProviderProtocol {
    func getRandomItem() async -> (ItemModel?, CommonItemProviderError?)
    func getRandomAction() async -> (ActionModel?, CommonItemProviderError?)
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
    let actionDataStore: ActionDataStoreProtocol
    
    let menuService: MenuServiceProtocol
    let actionService: ActionServiceProtocol
    let userService: UserServiceProtocol
    let sessionService: UserSessionServiceProtocol
    
    let imageLoader: ImageLoaderProtocol
    let imageDataStore: ImageDataStoreProtocol

    init(menuDataStore: MenuDataStoreProtocol = MenuDataStore.shared,userDataStore: UserDataStoreProtocol = UserDataStore.shared, menuService: MenuServiceProtocol = MenuService.shared, userService: UserServiceProtocol = UserService.shared, sessionService: UserSessionServiceProtocol = UserSessionService.shared,imageLoader: ImageLoaderProtocol = ImageLoader.shared, imageDataStore: ImageDataStoreProtocol = ImageDataStore.shared, actionDataStore: ActionDataStoreProtocol = ActionDataStore.shared, actionService: ActionServiceProtocol = ActionService.shared) {
        
        self.userDataStore = userDataStore
        self.menuDataStore = menuDataStore
        self.actionDataStore = actionDataStore
        
        self.menuService = menuService
        self.sessionService = sessionService
        self.userService = userService
        self.actionService = actionService
        
        self.imageDataStore = imageDataStore
        self.imageLoader = imageLoader
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
        if !cashedItems.isEmpty {
            return (cashedItems.randomElement(), nil)
        }
        
        let (items, error) = await menuService.fetchItems()
        
        if let error = error {
            return (nil, .getItemFailed(underlyingError: error))
        } else if var images = items {
            if images.isEmpty == false {
                images = await setImagesToItems(items: images)
                menuDataStore.saveItems(images)
                return (images.randomElement(), nil)
            }
            else{
                return (nil, .emptyData)
            }
        }
        else {
            return (nil, .unknown)
        }
    }
    
    func getRandomAction() async -> (ActionModel?, CommonItemProviderError?) {
        let cashedItems = actionDataStore.fetchActions()
        if !cashedItems.isEmpty {
            return (cashedItems.randomElement(), nil)
        }
        
        let (items, error) = await actionService.fetchActions()
        
        if let error = error {
            return (nil, .getItemFailed(underlyingError: error))
        } else if let images = items {
            if images.isEmpty == false {
                actionDataStore.saveActions(images)
                return (images.randomElement(), nil)
            }
            else{
                return (nil, .emptyData)
            }
        }
        else {
            return (nil, .unknown)
        }
    }
    
    func setImagesToItems(items: [ItemModel]) async -> [ItemModel]{
        var ans = items
        for (idx, item) in ans.enumerated(){
            ans[idx].itemImage = await getImage(path: item.imagePath)
        }
                    
        return ans
    }
    
    private func getImage(path: String) async -> UIImage? {
        if let image = imageDataStore.getImage(by: path){
            return image
        }
        let (image, _) = await imageLoader.downloadImage(path: path)
        return image
    }
}
