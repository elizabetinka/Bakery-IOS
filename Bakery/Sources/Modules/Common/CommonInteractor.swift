//
//  Отвечает за логику главного экрана
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import Foundation

protocol CommonBusinessLogic {
    func showUserInfo(request: Common.ShowUserInfo.Request) async
    func showItem(request: Common.ShowItem.Request) async
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
    func showUserInfo(request: Common.ShowUserInfo.Request) async {
        
        if Thread.isMainThread {
            print("CommonInteractor: Мы на главном потоке")
        } else {
            print("CommonInteractor: Мы на фоновом потоке")
        }
        
        let (info, error) = await provider.getCurrentUserInfo()
        
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
        await self.presenter.presentUserInfo(response: Common.ShowUserInfo.Response(result: result))
    }
    
    func showItem(request: Common.ShowItem.Request) async {
        
        let (item, error) = await provider.getRandomItem()
        
        let result: Common.ShowItem.CommonRequestResult
        if let image = item {
            result =  .success(image)
        } else if let error = error {
            switch error {
            case .getItemFailed(_):
                result = .failure(.someError(message: error.localizedDescription))
            case .emptyData:
                result = .emptyResult
            default:
                result = .failure(.someError(message: "No Data"))
            }
        } else {
            result = .failure(.someError(message: "No Data"))
        }
        await self.presenter.presentItem(response: Common.ShowItem.Response(result: result))
    }
}
