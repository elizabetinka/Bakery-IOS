//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

protocol UserProviderProtocol {
    //func getItems(completion: @escaping ([UserModel]?, UserProviderError?) -> Void)
}

//enum UserProviderError: Error {
//    case getItemsFailed(underlyingError: Error)
//}

/// Отвечает за получение данных модуля User
struct UserProvider: UserProviderProtocol {
    let dataStore: UserDataStore
    let service: UserServiceProtocol

    init(dataStore: UserDataStore = UserDataStore(), service: UserServiceProtocol = UserService()) {
        self.dataStore = dataStore
        self.service = service
    }

//    func getItems(completion: @escaping ([UserModel]?, UserProviderError?) -> Void) {
//        if dataStore.models?.isEmpty == false {
//            return completion(self.dataStore.models, nil)
//        }
//        service.fetchItems { (array, error) in
//            print("fetchItems")
//            if let error = error {
//                completion(nil, .getItemsFailed(underlyingError: error))
//                print("fetchItems1")
//            } else if let models = array {
//                self.dataStore.models = models
//                completion(self.dataStore.models, nil)
//            }
//            print("fetchItems2")
//        }
//    }
}
