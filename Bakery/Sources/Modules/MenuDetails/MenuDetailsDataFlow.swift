//
//  item details
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

enum MenuDetails {
    // MARK: Use cases
    enum ShowDetails {
        struct Request {
            let itemId: UniqueIdentifier
        }

        struct Response {
            var result: MenuDetailsRequestResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }

    enum MenuDetailsRequestResult {
        case failure(MenuDetailsError)
        case success(ItemModel)
        case notExists
    }

    enum ViewControllerState {
        case initial(id: UniqueIdentifier)
        case loading
        case result(MenuDetailsViewModel)
        case emptyResult
        case error(message: String)
    }

    enum MenuDetailsError: Error {
        case someError(message: String)
    }
}
