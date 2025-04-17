//
//  user registration logic
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

class UserRegistrationBuilder: ModuleBuilder {

    var initialState: UserRegistration.ViewControllerState?

    func set(initialState: UserRegistration.ViewControllerState) -> UserRegistrationBuilder {
        self.initialState = initialState
        return self
    } 

    func build() -> UIViewController {
        let presenter = UserRegistrationPresenter()
        let interactor = UserRegistrationInteractor(presenter: presenter)
        let controller = UserRegistrationViewController(interactor: interactor)

        presenter.viewController = controller
        return controller
    }
}
