//
//  Отвечает за универсальный экран для bd ui
//  Created by Елизавета Кравченкова on 20/05/2025.
//

import UIKit

class UniversalBuilder: ModuleBuilder {

    var initialState: Universal.ViewControllerState?
    var router: TabBarRouterProtocol?
    var config: UniversalScreenConfig = .init(endpoint: "", key: "")

    func set(initialState: Universal.ViewControllerState) -> UniversalBuilder {
        self.initialState = initialState
        return self
    }
    
    func set(router : TabBarRouterProtocol) -> UniversalBuilder {
        self.router = router
        return self
    }
    
    func set(config: UniversalScreenConfig) -> UniversalBuilder {
            self.config = config
            return self
    }

    func build() -> UIViewController {
        let presenter = UniversalPresenter()
        let interactor = UniversalInteractor(presenter: presenter)
        let controller = UniversalViewController(interactor: interactor, config: config)

        presenter.viewController = controller
        presenter.delegate = controller as? any UniversalDelegate
        controller.router = router
        return controller
    }
}
