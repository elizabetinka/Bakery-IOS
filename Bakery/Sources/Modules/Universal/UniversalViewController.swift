//
//  Отвечает за универсальный экран для bd ui
//  Created by Елизавета Кравченкова on 20/05/2025.
//

import UIKit

protocol UniversalDelegate: AnyObject {
    // some custom func for bd ui
    func registerHandlers()
    
    func refreshData()
}

protocol UniversalDisplayLogic: AnyObject {
    func displaySomething(viewModel: Universal.Init.ViewModel)
    func displaySomething(viewModel: Universal.Cashe.ViewModel)
}

struct UniversalScreenConfig {
    let endpoint: String
    let key: String
}

class UniversalViewController: UIViewController {
    let interactor: UniversalBusinessLogic
    let config: UniversalScreenConfig
    var state: Universal.ViewControllerState
    weak var router: TabBarRouterProtocol?
    
    lazy var customView = self.view as? UniversalViewProtocol
    

    init(interactor: UniversalBusinessLogic, config: UniversalScreenConfig, initialState: Universal.ViewControllerState = .initial) {
        self.interactor = interactor
        self.state = initialState
        self.config = config
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = UniversalView(frame: UIScreen.main.bounds)
        self.view = view
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("UniversalViewController.viewDidLoad")
        display(newState: state)
    }

    func initRequest() async {
        casheRequest()
        await interactor.initRequest(request: Universal.Init.Request(config: config))
    }
    
    func casheRequest(){
        interactor.casheRequest(request: Universal.Cashe.Request(config: config))
    }
}

extension UniversalViewController: UniversalDisplayLogic {
    func displaySomething(viewModel: Universal.Cashe.ViewModel) {
        display(newState: viewModel.state)
    }
    func displaySomething(viewModel: Universal.Init.ViewModel) {
        display(newState: viewModel.state)
    }
    
    func display(newState: Universal.ViewControllerState) {
        state = newState
        switch state {
        case .initial:
            Task {
                await initRequest()
            }
        case let .setup(model):
            customView?.setup(with: model)
        }
    }
}

extension UniversalViewController: UniversalDelegate{
    
    func registerHandlers() {
        ActionHandler<Void>.shared().registerHandler(for: HandlerModel(custom: "some-screen/refresh"), handler: {
            self.refreshData()
        })
    }

    func refreshData() {
        print("UniversalViewController.reloadData")
        Task {
            await initRequest()
        }
    }
}

