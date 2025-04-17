//
//  User actions module
//  Created by Елизавета Кравченкова on 09/04/2025.
//

protocol UserBusinessLogic {
    func showUserInfo(request: User.ShowUserInfo.Request)
}

/// Класс для описания бизнес-логики модуля User
class UserInteractor: UserBusinessLogic {
    let presenter: UserPresentationLogic
    let provider: UserProviderProtocol

    init(presenter: UserPresentationLogic, provider: UserProviderProtocol = UserProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: Do something
    func showUserInfo(request: User.ShowUserInfo.Request) {
                
        provider.getCurrentUserInfo { (info, error) in
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
            self.presenter.presentUserInfo(response: User.ShowUserInfo.Response(result: result))
            
        }
        
    }
}
