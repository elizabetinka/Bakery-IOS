//
//  menu logic
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

enum Menu {
    // MARK: show items in menu screen
    enum ShowItems {
        struct Request {
        }

        struct Response {
            var result: MenuRequestResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }

    enum MenuRequestResult {
        case failure(MenuError)
        case success([ItemModel])
    }

    enum ViewControllerState {
        case loading
        case result([ItemViewModel])
        case emptyResult
        case error(message: String)
    }

    enum MenuError: Error {
        case someError(message: String)
    }
}
