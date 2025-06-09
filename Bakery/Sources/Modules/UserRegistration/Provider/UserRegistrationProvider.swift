//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

protocol UserRegistrationProviderProtocol {
    func registryNewUser(addModel : UserModel) async -> (Bool, UserRegistrationProviderError?)
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
    
    func registryNewUser(addModel : UserModel) async  -> (Bool, UserRegistrationProviderError?){
        
        if dataStore.fetchUsers().first(where: { $0.phoneNumber == addModel.phoneNumber }) != nil{
            return (true, .alreadyExists)
        }
        
        let (user, error) = await service.addUser(user: addModel)
        
        if let error = error {
            switch error {
            case .alreadyExists:
                return (false, .alreadyExists)
            default:
                return (false, .getUserFailed(underlyingError: error))
            }
        } else if let model = user {
            self.dataStore.addUser(model)
            sessionService.setCurrentUserId(id: model.uid)
            return (true, nil)
        }
        else{
            return (false, .unknown)
        }
    
    }
}
