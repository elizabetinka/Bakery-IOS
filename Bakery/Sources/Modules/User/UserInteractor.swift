//
//  User actions module
//  Created by Елизавета Кравченкова on 09/04/2025.
//

protocol UserBusinessLogic {
    func showModule(request: User.ShowModule.Request)
}

/// Класс для описания бизнес-логики модуля User
class UserInteractor: UserBusinessLogic {
    let presenter: UserPresentationLogic
    let provider: UserProviderProtocol
    let authWorker: AuthChekerWorker
    let userWorker: UserWorker

    init(presenter: UserPresentationLogic, provider: UserProviderProtocol = UserProvider(), authWorker : AuthChekerWorker, userWorker: UserWorker) {
        self.presenter = presenter
        self.provider = provider
        self.authWorker = authWorker
        self.userWorker = userWorker
    }
    
    // MARK: Do something
    func showModule(request: User.ShowModule.Request) {
        
        //var userInfo : CommonModel.UserInfo? = nil
        
        userWorker.getInfo { (info, error) in
            let result: User.UserRequestResult

            if let error = error {
                result = .failure(.someError(message: error.localizedDescription))
            }
            else if let info = info {
                let model = UserModel(userStatus: UserModel.UserStatus.isEntered(UserModel.UserInfo(name: info.name, points: info.points, phoneNumber: info.phoneNumner)))
                result = .success(model)
            }
            else {
                result = .failure(.someError(message: "No Data"))
            }
            self.presenter.presentModule(response: User.ShowModule.Response(result: result))
        }
        
        //let result: User.UserRequestResult
        
        
//        provider.getItems { (items, error) in
//            let result: User.UserRequestResult
//            if let items = items {
//                result = .success(items)
//            } else if let error = error {
//                result = .failure(.someError(message: error.localizedDescription))
//            } else {
//                result = .failure(.someError(message: "No Data"))
//            }
//            self.presenter.presentSomething(response: User.Something.Response(result: result))
//        }
    }
}
