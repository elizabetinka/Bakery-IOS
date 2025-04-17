//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

protocol UserProviderProtocol {
    func getCurrentUserInfo(completion: @escaping (UserModel?, UserProviderError?) -> Void)
}

enum UserProviderError: Error {
    case getUserFailed(underlyingError: Error)
    case notAuthorized
    case unknown
}

/// Отвечает за получение данных модуля User
struct UserProvider: UserProviderProtocol {
    
    let dataStore: UserDataStoreProtocol
    let service: UserServiceProtocol
    let sessionService : UserSessionService

    init(dataStore: UserDataStore = UserDataStore.shared, service: UserServiceProtocol = UserService.shared, sessionService : UserSessionService = UserSessionService.shared) {
        self.dataStore = dataStore
        self.service = service
        self.sessionService = sessionService
    }
    
    func getCurrentUserInfo(completion: @escaping (UserModel?, UserProviderError?) -> Void) {
        guard let id = self.sessionService.getCurrentUserId() else {
            return completion(nil, .notAuthorized)
        }
        
        if let info = dataStore.fetchUser(by: id) {
            return completion(info, nil)
        }
        
        service.fetchUser(by: id ) { (info, error) in
            if let error = error {
                switch error {
                case .notExists:
                    completion(nil, .notAuthorized)
                default:
                    completion(nil, .getUserFailed(underlyingError: error))
                }
            } else if let model = info {
                self.dataStore.addUser(model)
                completion(model, nil)
            }
            else{
                completion(nil, .unknown)
            }
        }
        
        
    }
}
