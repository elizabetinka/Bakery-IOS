//
//  Отвечает за аутентификацию пользователя
//  Created by Елизавета Кравченкова on 10/04/2025.
//

import UIKit

class UserAutentificationBuilder: ModuleBuilder {

    var initialState: UserAutentification.ViewControllerState?
    var router: TabBarRouterProtocol?

    func set(initialState: UserAutentification.ViewControllerState) -> UserAutentificationBuilder {
        self.initialState = initialState
        return self
    }
    
    func set(router : TabBarRouterProtocol) -> UserAutentificationBuilder {
        self.router = router
        return self
    }

    func build() -> UIViewController {
        let presenter = UserAutentificationPresenter()
        let interactor = UserAutentificationInteractor(presenter: presenter)
        let controller = UserAutentificationViewController(interactor: interactor)

        presenter.viewController = controller
        controller.router = router
        return controller
    }
}
