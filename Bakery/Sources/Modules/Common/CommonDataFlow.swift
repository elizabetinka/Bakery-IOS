//
//  Отвечает за логику главного экрана
//  Created by Елизавета Кравченкова on 09/04/2025.
//

enum Common {
    // MARK: Use cases
    enum ShowUserInfo {
        struct Request {
        }

        struct Response {
            var result: CommonRequestResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
        
        enum CommonRequestResult {
            case failure(CommonError)
            case success(UserModel)
            case notAuthorized
        }
        
        enum ViewControllerState {
            case loading
            case authorizedResult(CommonUserViewModel)
            case notAuthorized
            case error(message: String)
        }
    }
    
    enum ShowItem {
        struct Request {
        }

        struct Response {
            var result: CommonRequestResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
        
        enum CommonRequestResult {
            case failure(CommonError)
            case success(ItemModel)
            case emptyResult
        }
        
        enum ViewControllerState {
            case loading
            case result(CommonItemViewModel)
            case emptyResult
            case error(message: String)
        }
    }

    enum CommonError: Error {
        case someError(message: String)
    }
}
