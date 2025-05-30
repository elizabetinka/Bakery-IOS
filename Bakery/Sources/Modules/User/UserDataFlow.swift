//
//  User actions module
//  Created by Елизавета Кравченкова on 09/04/2025.
//

enum User {
    // MARK: Use cases
    enum ShowUserInfo {
        struct Request {
        }

        struct Response {
            var result: UserRequestResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }

    enum UserRequestResult {
        case failure(UserError)
        case success(UserModel)
        case notAuthorized
    }

    enum ViewControllerState {
        case loading
        case result(UserInfoViewModel)
        case notAuthorized
        case error(message: String)
    }

    enum UserError: Error {
        case someError(message: String)
    }
}
