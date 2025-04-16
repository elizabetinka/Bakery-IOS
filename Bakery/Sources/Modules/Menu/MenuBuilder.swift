//
//  menu logic
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

class MenuBuilder: ModuleBuilder {

    var initialState: Menu.ViewControllerState?

    func set(initialState: Menu.ViewControllerState) -> MenuBuilder {
        self.initialState = initialState
        return self
    } 

    func build() -> UIViewController {
        let presenter = MenuPresenter()
        let interactor = MenuInteractor(presenter: presenter)
        let controller = MenuViewController(interactor: interactor)

        presenter.viewController = controller
        return controller
    }
}
