//
//  Отвечает за логику главного экрана
//  Created by Елизавета Кравченкова on 09/04/2025.
//

enum Common {
    // MARK: Use cases
    enum ShowModule {
        struct Request {
        }

        struct Response {
            var result: CommonRequestResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }

    enum CommonRequestResult {
        case failure(CommonError)
        case success(CommonModel)
    }

    enum ViewControllerState {
        case loading
        case authorizedResult(CommonViewModel)
        case notAuthorizedResult(CommonViewModel)
        case error(message: String)
    }

    enum CommonError: Error {
        case someError(message: String)
    }
}
