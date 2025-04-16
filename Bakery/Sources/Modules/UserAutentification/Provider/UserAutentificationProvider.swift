//
//  Created by Елизавета Кравченкова on 10/04/2025.
//

protocol UserAutentificationProviderProtocol {
    func getUserByPhoneNumber(phoneNumber: String, completion: @escaping (UserModel?, UserAutentificationProviderError?) -> Void)
}

enum UserAutentificationProviderError: Error {
    case getUserFailed(underlyingError: Error)
    case notRegistred
    case unknown
}

/// Отвечает за получение данных модуля User
struct UserAutentificationProvider: UserAutentificationProviderProtocol {
    
    let dataStore: UserDataStoreProtocol
    let service: UserServiceProtocol
    let sessionService : UserSessionService

    init(dataStore: UserDataStore = UserDataStore.shared, service: UserServiceProtocol = UserService.shared, sessionService : UserSessionService = UserSessionService.shared) {
        self.dataStore = dataStore
        self.service = service
        self.sessionService = sessionService
    }
    
    func getUserByPhoneNumber(phoneNumber: String, completion: @escaping (UserModel?, UserAutentificationProviderError?) -> Void) {
        
        if let user = dataStore.fetchUsers().first(where: { $0.phoneNumner == phoneNumber }){
            completion(user, nil)
        }
        service.fetchUsers { (info, error) in
            if let error = error {
                completion(nil, .getUserFailed(underlyingError: error))
            } else if let models = info {
                if let user = models.first(where: { $0.phoneNumner == phoneNumber }){
                    self.dataStore.addUser(user)
                    sessionService.setCurrentUserId(id: user.uid)
                    completion(user, nil)
                }
                else{
                    self.dataStore.saveUsers(models)
                    completion(nil, .notRegistred)
                }
            }
            else{
                completion(nil, .unknown)
            }
        }
        
        
    }
}
