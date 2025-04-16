//
//  Отвечает за логику главного экрана
//  Created by Елизавета Кравченкова on 09/04/2025.
//

protocol CommonBusinessLogic {
    func getInformation(request: Common.ShowModule.Request)
}

/// Класс для описания бизнес-логики модуля Common
class CommonInteractor: CommonBusinessLogic {
    let presenter: CommonPresentationLogic
    let provider: CommonProviderProtocol
    let authWorker: AuthChekerWorker
    let userWorker: UserWorker

    init(presenter: CommonPresentationLogic, provider: CommonProviderProtocol = CommonProvider(), authWorker : AuthChekerWorker, userWorker: UserWorker) {
        self.presenter = presenter
        self.provider = provider
        self.authWorker = authWorker
        self.userWorker = userWorker
    }
    
    // MARK: Do something
    func getInformation(request: Common.ShowModule.Request) {
        
        //let result: Common.CommonRequestResult
//        var isAuth : Bool
        
        
//        authWorker.isAuth { (isAuthRes, error) in
//            let result: Common.CommonRequestResult
//            if let error = error {
//                result = .failure(.someError(message: error.localizedDescription))
//                self.presenter.presentModule(response: Common.ShowModule.Response(result: result))
//            }
//            if let isAuthUnwrapped = isAuthRes {
//                isAuth = isAuthUnwrapped
//            }
//        }
        
        var userInfo : CommonModel.UserInfo? = nil
        
        userWorker.getInfo { (info, error) in
            let result: Common.CommonRequestResult
            if let error = error {
                result = .failure(.someError(message: error.localizedDescription))
                self.presenter.presentModule(response: Common.ShowModule.Response(result: result))
            }
            if let info = info {
                userInfo = CommonModel.UserInfo(name: info.name, points: info.points)
            }
        }
        
        provider.getImage { (image, error) in
            let result: Common.CommonRequestResult
            if let image = image {
                result = .success(CommonModel(userInfo: userInfo, menuImage: image))
            } else if let error = error {
                result = .failure(.someError(message: error.localizedDescription))
            } else {
                result = .failure(.someError(message: "No Data"))
            }
            self.presenter.presentModule(response: Common.ShowModule.Response(result: result))
        }
    }
}
