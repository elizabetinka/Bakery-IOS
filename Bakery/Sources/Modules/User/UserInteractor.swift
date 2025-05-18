//
//  User actions module
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import Foundation

protocol UserBusinessLogic {
    //func showUserInfo(request: User.ShowUserInfo.Request) async
    func initRequest(request: User.Init.Request) async
    @MainActor  func loadingRequest(request: User.Loading.Request)
    @MainActor  func reloadRequest(request: User.Reload.Request)
}

/// Класс для описания бизнес-логики модуля User
class UserInteractor: UserBusinessLogic {
    let presenter: UserPresentationLogic
    let provider: UserProviderProtocol
    
    init(presenter: UserPresentationLogic, provider: UserProviderProtocol = UserProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    func initRequest(request: User.Init.Request) async {
        let (info, error) = await provider.getCurrentUserInfo()
        
        let result: User.UserRequestResult
        
        if let error = error {
            switch error {
            case .getUserFailed(_):
                result = .failure(.someError(message: error.localizedDescription))
            case .notAuthorized:
                result = .notAuthorized
            case .unknown:
                result = .failure(.someError(message: "No Data"))
            }
        }
        else if let info = info {
            result = .success(info)
        }
        else {
            result = .failure(.someError(message: "No Data"))
        }
        await presenter.presentInitialData(response: User.Init.Response(result: result))
    }
    
    @MainActor func loadingRequest(request: User.Loading.Request) {
        presenter.presentLoadingData(response: User.Loading.Response())
    }
    
    @MainActor func reloadRequest(request: User.Reload.Request) {
        presenter.presentReloadData(response: User.Reload.Response())
    }
}
