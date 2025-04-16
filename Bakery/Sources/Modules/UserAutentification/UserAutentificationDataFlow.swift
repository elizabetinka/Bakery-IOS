//
//  Отвечает за аутентификацию пользователя
//  Created by Елизавета Кравченкова on 10/04/2025.
//

enum UserAutentification {
    // MARK: Use cases
    enum ShowModule {
        struct Request {
        }

        struct Response {
            var result: UserAutentificationShowModuleResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    enum UserAutentificationShowModuleResult {
        case failure(UserAutentificationError)
        case success
    }

    enum ViewControllerState {
        case loading
        case result
        case error(message: String)
    }

    enum UserAutentificationError: Error {
        case someError(message: String)
    }
    
    enum InterAuthInformation {
        struct Request {
            var phoneNumner : String
        }

        struct Response {
            var result: UserAutentificationRequestResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }

    
    enum UserAutentificationRequestResult {
        case failure(UserAutentificationError)
        case success([UserAutentificationModel])
    }
}
