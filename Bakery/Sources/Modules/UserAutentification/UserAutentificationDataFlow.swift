//
//  Отвечает за аутентификацию пользователя
//  Created by Елизавета Кравченкова on 10/04/2025.
//

enum UserAutentification {
    // MARK: Use cases
    
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
    
    enum ViewControllerState {
        case loading
        case success
        case notRegistred
        case error(message: String)
    }

}
