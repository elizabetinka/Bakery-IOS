//
//  Отвечает за аутентификацию пользователя
//  Created by Елизавета Кравченкова on 10/04/2025.
//

protocol UserAutentificationBusinessLogic {
    func login(request: UserAutentification.Login.Request) async
    @MainActor  func initRequest(request: UserAutentification.Init.Request)
    @MainActor  func loadingRequest(request: UserAutentification.Loading.Request)
    @MainActor  func reloadRequest(request: UserAutentification.Reload.Request)
    @MainActor func validatePhoneNumber(request: UserAutentification.ValidatePhoneNumber.Request)
}

/// Класс для описания бизнес-логики модуля UserAutentification
class UserAutentificationInteractor: UserAutentificationBusinessLogic {
    
    let presenter: UserAutentificationPresentationLogic
    let provider: UserAutentificationProviderProtocol
    

    init(presenter: UserAutentificationPresentationLogic, provider: UserAutentificationProviderProtocol = UserAutentificationProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: Login
    func login(request: UserAutentification.Login.Request) async {
        var result: UserAutentification.UserAutentificationRequestResult
        
        if request.form.phoneNumner.isEmpty {
            result = .failure(message: "Введите номер телефона")
            await self.presenter.presentLoginResult(response: UserAutentification.Login.Response(result: result))
            return
        }
        
        let (info, error) = await provider.getUserByPhoneNumber(phoneNumber: request.form.phoneNumner)
        
        if let error = error {
            switch error {
            case .getUserFailed(_):
                result = .failure(message: error.localizedDescription)
            case .notRegistred:
                result = .notRegistred
            case .unknown:
                result = .failure(message: "No Data")
            }
        }
        else if info != nil {
            result = .success
        }
        else {
            result = .failure(message: "No Data")
        }
        await self.presenter.presentLoginResult(response: UserAutentification.Login.Response(result: result))
    }
    
    @MainActor func initRequest(request: UserAutentification.Init.Request) {
        presenter.presentInitialData(response: UserAutentification.Init.Response())
    }
    
    @MainActor func loadingRequest(request: UserAutentification.Loading.Request) {
        presenter.presentLoadingData(response: UserAutentification.Loading.Response())
    }
    
    func reloadRequest(request: UserAutentification.Reload.Request) {
        presenter.presentReloadData(response: UserAutentification.Reload.Response())
    }
            
    
    @MainActor func validatePhoneNumber(request: UserAutentification.ValidatePhoneNumber.Request){
        
        var result: UserAutentification.UserAutentificationValidateResult = .success
        
        if request.form.phoneNumner.isEmpty {
            result = .failure(message: "Введите номер телефона")
        }
        else if (!request.form.phoneNumner.isValidPhone(AppConfig.phoneRegex)){
            result = .failure(message: "Неккоректный формат")
        }
        
        self.presenter.presentValidatedPhone(response:  UserAutentification.ValidatePhoneNumber.Response(result: result))
    }
    
}
