//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

protocol MenuDetailsProviderProtocol {
    func fetchItemDetails(by id: UniqueIdentifier, completion: @escaping (ItemModel?, MenuDetailsProviderError?) -> Void)
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

    init(dataStore: MenuDataStore = MenuDataStore.shared, service: MenuServiceProtocol = MenuService.shared) {
        self.dataStore = dataStore
        self.service = service
    }

    func fetchItemDetails(by id: UniqueIdentifier, completion: @escaping (ItemModel?, MenuDetailsProviderError?) -> Void) {
        if let item = dataStore.fetchItem(by: id) {
            return completion(item, nil)
        }
        service.fetchItem (by: id) { (item, error) in
            if let error = error {
                switch error {
                case .notExists:
                    completion(nil, .notExist)
                default:
                    completion(nil, .getItemFailed(underlyingError: error))
                }
            } else if let model = item {
                self.dataStore.addItem(model)
                completion(item, nil)
            }
            else{
                completion(nil, .unknown)
            }
        }
    }
}
