//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

protocol MenuProviderProtocol {
    func getItems()  async -> ([ItemModel]?, MenuProviderError?)
}

enum MenuProviderError: Error {
    case getMenuFailed(underlyingError: Error)
    case unknown
}

/// Отвечает за получение данных модуля MenuÍ
struct MenuProvider: MenuProviderProtocol {
    let dataStore: MenuDataStoreProtocol
    let service: MenuServiceProtocol

    init(dataStore: MenuDataStore = MenuDataStore.shared, service: MenuServiceProtocol = MenuService.shared) {
        self.dataStore = dataStore
        self.service = service
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
}
