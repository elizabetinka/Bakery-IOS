//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

protocol MenuProviderProtocol {
    func getItems()  async -> ([ItemModel]?, MenuProviderError?)
    func setImagesToItems(items: [ItemModel])  async -> [ItemModel]
}

enum MenuProviderError: Error {
    case getMenuFailed(underlyingError: Error)
    case unknown
}

/// Отвечает за получение данных модуля MenuÍ
struct MenuProvider: MenuProviderProtocol {
    let dataStore: MenuDataStoreProtocol
    let service: MenuServiceProtocol
    let imageLoader: ImageLoaderProtocol
    let imageDataStore: ImageDataStoreProtocol

    init(dataStore: MenuDataStore = MenuDataStore.shared, service: MenuServiceProtocol = MenuService.shared, imageLoader: ImageLoaderProtocol = ImageLoader.shared, imageDataStore: ImageDataStoreProtocol = ImageDataStore.shared) {
        self.dataStore = dataStore
        self.service = service
        self.imageLoader = imageLoader
        self.imageDataStore = imageDataStore
    }

    func getItems() async -> ([ItemModel]?, MenuProviderError?){
        
        let cashedItems =  dataStore.fetchItems()
        if cashedItems.isEmpty == false {
            return (cashedItems, nil)
        }
        
        let (array, error) = await service.fetchItems()
        
        if let error = error {
            return (nil, .getMenuFailed(underlyingError: error))
        } else if let models = array {
            self.dataStore.saveItems(models)
            return (models, nil)
        }
        else{
            return (nil, .unknown)
        }
        
    }
    
    func setImagesToItems(items: [ItemModel]) async -> [ItemModel]{
        var ans = items
        for (idx, item) in ans.enumerated(){
            ans[idx].itemImage = await getImages(path: item.imagePath)
        }
                    
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
