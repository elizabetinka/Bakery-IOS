//
//  Отвечает за логику главного экрана
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

class CommonBuilder: ModuleBuilder {

    var state: Common.ViewControllerState?
    var router: TabBarRouterProtocol?

    func set(itemInitialState: Common.ViewControllerState) -> CommonBuilder {
        self.state = itemInitialState
        return self
    }
    
    func set(router : TabBarRouterProtocol) -> CommonBuilder {
        self.router = router
        return self
    }

    @MainActor func build() -> UIViewController {
        let presenter = CommonPresenter()
        let interactor = CommonInteractor(presenter: presenter)
        let controller = CommonViewController(interactor: interactor)

        presenter.viewController = controller
        presenter.cardsDelegate = controller
        controller.router = router
        return controller
    }
}
