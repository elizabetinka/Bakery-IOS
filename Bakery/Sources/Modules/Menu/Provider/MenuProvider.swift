//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

protocol MenuProviderProtocol {
    func getItems(completion: @escaping ([ItemModel]?, MenuProviderError?) -> Void)
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

    func getItems(completion: @escaping ([ItemModel]?, MenuProviderError?) -> Void) {
        if dataStore.fetchItems().isEmpty == false {
            return completion(self.dataStore.fetchItems(), nil)
        }
        service.fetchItems { (array, error) in
            if let error = error {
                completion(nil, .getMenuFailed(underlyingError: error))
            } else if let models = array {
                self.dataStore.saveItems(models)
                completion(models, nil)
            }
            else{
                completion(nil, .unknown)
            }
        }
    }
}
