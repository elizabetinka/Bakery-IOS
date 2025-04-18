//
//  User actions module
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

class UserBuilder: ModuleBuilder {

    var initialState: User.ViewControllerState?
    var router: TabBarRouterProtocol?

    func set(initialState: User.ViewControllerState) -> UserBuilder {
        self.initialState = initialState
        return self
    }
    
    func set(router : TabBarRouterProtocol) -> UserBuilder {
        self.router = router
        return self
    }
    func build() -> UIViewController {
        let presenter = UserPresenter()
        let interactor = UserInteractor(presenter: presenter)
        let controller = UserViewController(interactor: interactor)

        presenter.viewController = controller
        controller.router = router
        return controller
    }
}
