//
//  Отвечает за логику главного экрана
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

class CommonBuilder: ModuleBuilder {

    var userInitialState: Common.ShowUserInfo.ViewControllerState?
    var itemInitialState: Common.ShowItem.ViewControllerState?
    var router: TabBarRouterProtocol?

    func set(userInitialState: Common.ShowUserInfo.ViewControllerState, itemInitialState: Common.ShowItem.ViewControllerState) -> CommonBuilder {
        self.itemInitialState = itemInitialState
        self.userInitialState = userInitialState
        return self
    }
    
    func set(router : TabBarRouterProtocol) -> CommonBuilder {
        self.router = router
        return self
    }

    func build() -> UIViewController {
        let presenter = CommonPresenter()
        let interactor = CommonInteractor(presenter: presenter)
        let controller = CommonViewController(interactor: interactor)

        presenter.viewController = controller
        controller.router = router
        return controller
    }
}
