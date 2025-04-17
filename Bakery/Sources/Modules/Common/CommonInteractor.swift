//
//  Отвечает за логику главного экрана
//  Created by Елизавета Кравченкова on 09/04/2025.
//

protocol CommonBusinessLogic {
    func showUserInfo(request: Common.ShowUserInfo.Request)
    func showItem(request: Common.ShowItem.Request)
}

/// Класс для описания бизнес-логики модуля Common
class CommonInteractor: CommonBusinessLogic {
    let presenter: CommonPresentationLogic
    let provider: CommonProviderProtocol

    init(presenter: CommonPresentationLogic, provider: CommonProviderProtocol = CommonProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: Do something
    func showUserInfo(request: Common.ShowUserInfo.Request) {
        
        provider.getCurrentUserInfo { (info, error) in
            let result: Common.ShowUserInfo.CommonRequestResult
            if let error = error {
                switch error {
                case .notAuthorized:
                    result = .notAuthorized
                case let .getUserFailed(underlyingError):
                    result = .failure(.someError(message: error.localizedDescription))
                default:
                    result = .failure(.someError(message: "No Data"))
                }
            }
            else if let info = info {
                result = .success(info)
            }
            else {
                result = .failure(.someError(message: "No Data"))
            }
            self.presenter.presentUserInfo(response: Common.ShowUserInfo.Response(result: result))
        }
    }
    
    func showItem(request: Common.ShowItem.Request) {
        
        provider.getRandomItem { (item, error) in
            let result: Common.ShowItem.CommonRequestResult
            if let image = item {
                result =  .success(image)
            } else if let error = error {
                switch error {
                case let .getItemFailed(underlyingError):
                    result = .failure(.someError(message: error.localizedDescription))
                case .emptyData:
                    result = .emptyResult
                default:
                    result = .failure(.someError(message: "No Data"))
                }
            } else {
                result = .failure(.someError(message: "No Data"))
            }
            self.presenter.presentItem(response: Common.ShowItem.Response(result: result))
        }
    }
}
