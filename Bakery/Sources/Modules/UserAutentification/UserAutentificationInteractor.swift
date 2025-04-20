//
//  Отвечает за аутентификацию пользователя
//  Created by Елизавета Кравченкова on 10/04/2025.
//

protocol UserAutentificationBusinessLogic {
    func login(request: UserAutentification.Login.Request) async
    func validatePhoneNumber(number: String) -> Bool
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
        
        let (info, error) = await provider.getUserByPhoneNumber(phoneNumber: request.form.phoneNumner)
        
        var result: UserAutentification.UserAutentificationRequestResult
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
            
    
    func validatePhoneNumber(number: String) -> Bool{
        return number.isValidPhone(AppConfig.phoneRegex)
    }
    
}
