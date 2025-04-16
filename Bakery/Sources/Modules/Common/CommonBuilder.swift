//
//  Отвечает за логику главного экрана
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

class CommonBuilder: ModuleBuilder {

    var initialState: Common.ViewControllerState?

    func set(initialState: Common.ViewControllerState) -> CommonBuilder {
        self.initialState = initialState
        return self
    } 

    func build() -> UIViewController {
        let presenter = CommonPresenter()
        let interactor = CommonInteractor(presenter: presenter)
        let controller = CommonViewController(interactor: interactor)

        presenter.viewController = controller
        return controller
    }
}
