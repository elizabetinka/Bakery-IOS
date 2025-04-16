//
//  Отвечает за аутентификацию пользователя
//  Created by Елизавета Кравченкова on 10/04/2025.
//

import UIKit

class UserAutentificationBuilder: ModuleBuilder {

    var initialState: UserAutentification.ViewControllerState?

    func set(initialState: UserAutentification.ViewControllerState) -> UserAutentificationBuilder {
        self.initialState = initialState
        return self
    } 

    func build() -> UIViewController {
        let presenter = UserAutentificationPresenter()
        let interactor = UserAutentificationInteractor(presenter: presenter)
        let controller = UserAutentificationViewController(interactor: interactor)

        presenter.viewController = controller
        return controller
    }
}
