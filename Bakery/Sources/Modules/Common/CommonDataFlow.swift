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
        }
    }
    
    enum ShowAction {
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
            case success(ActionModel)
        }
    }
    
    enum LoadingUserInfo {
        struct Request {
        }

        struct Response {
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    enum LoadingItem {
        struct Request {
        }

        struct Response {
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    enum LoadingAction {
        struct Request {
        }

        struct Response {
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    
    enum ViewControllerState {
        case initial
        case setup(model: CommonViewModel)
        case configure(model: CommonViewModel)
    }

    enum CommonError: Error {
        case someError(message: String)
    }
}
