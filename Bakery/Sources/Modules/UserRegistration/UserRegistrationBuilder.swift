//
//  user registration logic
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

class UserRegistrationBuilder: ModuleBuilder {

    var initialState: UserRegistration.ViewControllerState?
    var router: TabBarRouterProtocol?

    func set(initialState: UserRegistration.ViewControllerState) -> UserRegistrationBuilder {
        self.initialState = initialState
        return self
    }
    
    func set(router : TabBarRouterProtocol) -> UserRegistrationBuilder {
        self.router = router
        return self
    }

    func build() -> UIViewController {
        let presenter = UserRegistrationPresenter()
        let interactor = UserRegistrationInteractor(presenter: presenter)
        let controller = UserRegistrationViewController(interactor: interactor)

        presenter.viewController = controller
        presenter.buttonDelegate = controller as? any RegistrationButtonDelegate
        presenter.refreshActionsDelegate = controller as? any ErrorViewDelegate
        presenter.validateDelegate = controller as? any UserRegistrationValidateDelegate
        controller.router = router
        return controller
    }
}
