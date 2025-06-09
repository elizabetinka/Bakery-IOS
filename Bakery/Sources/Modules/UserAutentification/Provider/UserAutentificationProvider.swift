//
//  Created by Елизавета Кравченкова on 10/04/2025.
//

import Foundation

protocol UserAutentificationProviderProtocol {
    func getUserByPhoneNumber(phoneNumber: String) async -> (UserModel?, UserAutentificationProviderError?)
}

enum UserAutentificationProviderError: Error {
    case getUserFailed(underlyingError: Error)
    case notRegistred
    case unknown
}

extension UserAutentificationProviderError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .getUserFailed(underlyingError):
            return NSLocalizedString(underlyingError.localizedDescription, comment: "")
        case .notRegistred:
            return NSLocalizedString("Такого пользователя нет", comment: "")
        case .unknown:
            return NSLocalizedString("Неизвестная ошибка", comment: "")
        }
    }
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
    
    func getUserByPhoneNumber(phoneNumber: String) async -> (UserModel?, UserAutentificationProviderError?) {
        
        if let user = dataStore.fetchUsers().first(where: { $0.phoneNumber == phoneNumber }){
            sessionService.setCurrentUserId(id: user.uid)
            return (user, nil)
        }
        let (info, error) = await service.fetchUsers()
        
        if let error = error {
            return (nil, .getUserFailed(underlyingError: error))
        } else if let models = info {
            if let user = models.first(where: { $0.phoneNumber == phoneNumber }){
                self.dataStore.addUser(user)
                sessionService.setCurrentUserId(id: user.uid)
                return (user, nil)
            }
            else{
                self.dataStore.saveUsers(models)
                return (nil, .notRegistred)
            }
        }
        else{
            return (nil, .unknown)
        }
    }
}
