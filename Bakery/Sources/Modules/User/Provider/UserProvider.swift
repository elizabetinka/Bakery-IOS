//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

protocol UserProviderProtocol {
    func getCurrentUserInfo() async -> (UserModel?, UserProviderError?)
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
    
    func getCurrentUserInfo() async -> (UserModel?, UserProviderError?) {
        guard let id = self.sessionService.getCurrentUserId() else {
            return (nil, .notAuthorized)
        }
        
        if let info = dataStore.fetchUser(by: id) {
            return (info, nil)
        }
        
        let (info, error) = await service.fetchUser(by: id )
        
        if let error = error {
            switch error {
            case .notExists:
                return (nil, .notAuthorized)
            default:
                return (nil, .getUserFailed(underlyingError: error))
            }
        } else if let model = info {
            self.dataStore.addUser(model)
            return (model, nil)
        }
        else{
            return (nil, .unknown)
        }
        
    }
}
