//
//  item details
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

class MenuDetailsBuilder: ModuleBuilder {

    var initialState: MenuDetails.ViewControllerState?

    func set(initialState: MenuDetails.ViewControllerState) -> MenuDetailsBuilder {
        self.initialState = initialState
        return self
    } 

    func build() -> UIViewController {
        let presenter = MenuDetailsPresenter()
        let interactor = MenuDetailsInteractor(presenter: presenter)
        let controller = MenuDetailsViewController(interactor: interactor, initialState: initialState ?? .loading)

        presenter.viewController = controller
        return controller
    }
}
