//
//  Created by Елизавета Кравченкова on 10/04/2025.
//

protocol UserAutentificationProviderProtocol {
    func getItems(completion: @escaping ([UserAutentificationModel]?, UserAutentificationProviderError?) -> Void)
}

enum UserAutentificationProviderError: Error {
    case getItemsFailed(underlyingError: Error)
}

/// Отвечает за получение данных модуля UserAutentification
struct UserAutentificationProvider: UserAutentificationProviderProtocol {
    let dataStore: UserAutentificationDataStore
    let service: UserAutentificationServiceProtocol

    init(dataStore: UserAutentificationDataStore = UserAutentificationDataStore(), service: UserAutentificationServiceProtocol = UserAutentificationService()) {
        self.dataStore = dataStore
        self.service = service
    }

    func getItems(completion: @escaping ([UserAutentificationModel]?, UserAutentificationProviderError?) -> Void) {
        if dataStore.models?.isEmpty == false {
            return completion(self.dataStore.models, nil)
        }
        service.fetchItems { (array, error) in
            if let error = error {
                completion(nil, .getItemsFailed(underlyingError: error))
            } else if let models = array {
                self.dataStore.models = models
                completion(self.dataStore.models, nil)
            }
        }
    }
}
