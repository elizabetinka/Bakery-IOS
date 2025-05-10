//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

protocol MenuDetailsProviderProtocol {
    func fetchItemDetails(by id: UniqueIdentifier) async-> (ItemModel?, MenuDetailsProviderError?)
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
}
