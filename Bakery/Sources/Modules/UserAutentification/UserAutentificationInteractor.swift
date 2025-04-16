//
//  Отвечает за аутентификацию пользователя
//  Created by Елизавета Кравченкова on 10/04/2025.
//

protocol UserAutentificationBusinessLogic {
    func showModule(request: UserAutentification.ShowModule.Request)
}

/// Класс для описания бизнес-логики модуля UserAutentification
class UserAutentificationInteractor: UserAutentificationBusinessLogic {
    let presenter: UserAutentificationPresentationLogic
    let provider: UserAutentificationProviderProtocol

    init(presenter: UserAutentificationPresentationLogic, provider: UserAutentificationProviderProtocol = UserAutentificationProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: Do something
    func showModule(request: UserAutentification.ShowModule.Request) {
        let result : UserAutentification.UserAutentificationShowModuleResult
        result = .success
        self.presenter.showModule(response: UserAutentification.ShowModule.Response(result: result))
    }
}
