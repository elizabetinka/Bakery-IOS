//
//  Отвечает за аутентификацию пользователя
//  Created by Елизавета Кравченкова on 10/04/2025.
//

enum UserAutentification {
    // MARK: Use cases
    enum Init {
        struct Request {
        }

        struct Response {
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    enum Loading {
        struct Request {
        }

        struct Response {
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    enum Reload {
        struct Request {
        }

        struct Response {
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    enum ValidatePhoneNumber {
        struct Request {
            var form : UserAutentificationRequest
        }

        struct Response {
            var result: UserAutentificationValidateResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    
    enum Login {
        struct Request {
            var form : UserAutentificationRequest
        }

        struct Response {
            var result: UserAutentificationRequestResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    struct UserAutentificationRequest{
        let phoneNumner : String
    }
    
    enum UserAutentificationRequestResult {
        case failure(message: String)
        case success
        case notRegistred
    }
    
    enum UserAutentificationValidateResult {
        case failure(message: String)
        case success
    }
    
    enum ViewControllerState {
        case initial
        case setup(model: UserAutentificationViewModel)
        case configure(model: UserAutentificationViewModel)
        case success
        case notRegistred
    }

}
