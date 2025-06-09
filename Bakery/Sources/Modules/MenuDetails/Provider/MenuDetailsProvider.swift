//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

protocol MenuDetailsProviderProtocol {
    func fetchItemDetails(by id: UniqueIdentifier) async-> (ItemModel?, MenuDetailsProviderError?)
    func setImageToItem(item: ItemModel)  async -> ItemModel
}

enum MenuDetailsProviderError: Error {
    case getItemFailed(underlyingError: Error)
    case notExist
    case unknown
}

/// Отвечает за получение данных модуля MenuDetails
struct MenuDetailsProvider: MenuDetailsProviderProtocol {
    let dataStore: MenuDataStore
    let service: MenuServiceProtocol
    let imageLoader: ImageLoaderProtocol
    let imageDataStore: ImageDataStoreProtocol

    init(dataStore: MenuDataStore = MenuDataStore.shared, service: MenuServiceProtocol = MenuService.shared, imageLoader: ImageLoaderProtocol = ImageLoader.shared, imageDataStore: ImageDataStoreProtocol = ImageDataStore.shared) {
        self.dataStore = dataStore
        self.service = service
        self.imageLoader = imageLoader
        self.imageDataStore = imageDataStore
    }

    func fetchItemDetails(by id: UniqueIdentifier) async  -> (ItemModel?, MenuDetailsProviderError?){
        if let item = dataStore.fetchItem(by: id) {
            return (item, nil)
        }
        let (item, error) = await service.fetchItem (by: id)
        
        if let error = error {
            switch error {
            case .notExists:
                return (nil, .notExist)
            default:
                return (nil, .getItemFailed(underlyingError: error))
            }
        } else if let model = item {
            self.dataStore.addItem(model)
            return (item, nil)
        }
        else{
            return (nil, .unknown)
        }
    }
    
    func setImageToItem(item: ItemModel) async -> ItemModel {
        var ans = item
        ans.itemImage = await getImages(path: item.imagePath)
        return ans
    }
    
    private func getImages(path: String) async -> UIImage? {
        if let image = imageDataStore.getImage(by: path){
            return image
        }
        let (image, _) = await imageLoader.downloadImage(path: path)
        return image
    }
}
