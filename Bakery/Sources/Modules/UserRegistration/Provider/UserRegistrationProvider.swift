//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

protocol UserRegistrationProviderProtocol {
    func registryNewUser(addModel : UserModel, completion: @escaping (Bool, UserRegistrationProviderError?) -> Void)
}

enum UserRegistrationProviderError: Error {
    case getUserFailed(underlyingError: Error)
    case alreadyExists
    case unknown
}

/// Отвечает за получение данных модуля User
struct UserRegistrationProvider: UserRegistrationProviderProtocol {
    
    let dataStore: UserDataStoreProtocol
    let service: UserServiceProtocol
    let sessionService : UserSessionService

    init(dataStore: UserDataStore = UserDataStore.shared, service: UserServiceProtocol = UserService.shared, sessionService : UserSessionService = UserSessionService.shared) {
        self.dataStore = dataStore
        self.service = service
        self.sessionService = sessionService
    }
    
    func registryNewUser(addModel : UserModel, completion: @escaping (Bool, UserRegistrationProviderError?) -> Void) {
        
        if let user = dataStore.fetchUsers().first(where: { $0.phoneNumner == addModel.phoneNumner }){
            completion(true, .alreadyExists)
        }
        
        service.addUser(user: addModel) { (user, error) in
            if let error = error {
                switch error {
                case .alreadyExists:
                    completion(false, .alreadyExists)
                default:
                    completion(false, .getUserFailed(underlyingError: error))
                }
            } else if let model = user {
                self.dataStore.addUser(model)
                sessionService.setCurrentUserId(id: model.uid)
                completion(true, nil)
            }
            else{
                completion(false, .unknown)
            }
        }
        
        
    }
}
