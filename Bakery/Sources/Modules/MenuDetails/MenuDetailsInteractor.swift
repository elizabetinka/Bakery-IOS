//
//  item details
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

protocol MenuDetailsBusinessLogic {
    func fetchItemDetails(request: MenuDetails.ShowDetails.Request)
}

/// Класс для описания бизнес-логики модуля MenuDetails
class MenuDetailsInteractor: MenuDetailsBusinessLogic {
    let presenter: MenuDetailsPresentationLogic
    let provider: MenuDetailsProviderProtocol

    init(presenter: MenuDetailsPresentationLogic, provider: MenuDetailsProviderProtocol = MenuDetailsProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: Do something
    func fetchItemDetails(request: MenuDetails.ShowDetails.Request) {
        provider.fetchItemDetails(by: request.itemId ) {(item, error) in
            let result: MenuDetails.MenuDetailsRequestResult
            if let items = item {
                result = .success(items)
            } else if let error = error {
                switch error {
                case .notExist:
                    result = .notExists
                case let .getItemFailed(underlyingError):
                    result = .failure(.someError(message: error.localizedDescription))
                default:
                    result = .failure(.someError(message: "No Data"))
                }
            } else {
                result = .failure(.someError(message: "No Data"))
            }
            self.presenter.presentItemDetails(response: MenuDetails.ShowDetails.Response(result: result))
        }
    }
}
