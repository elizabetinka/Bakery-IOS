//
//  User actions module
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

protocol UserDisplayLogic: AnyObject {
    //func displayUserInfo(viewModel: User.ShowUserInfo.ViewModel)
    func displaySomething(viewModel: User.Init.ViewModel)
    func displaySomething(viewModel: User.Loading.ViewModel)
    func displaySomething(viewModel: User.Reload.ViewModel)
}

protocol UserRouterAppearance: AnyObject {
    func applyRouterSettigs()
}

class UserViewController: UIViewController {
    let interactor: UserBusinessLogic
    var state: User.ViewControllerState
    weak var router: TabBarRouterProtocol?
    lazy var customView = self.view as? UserView

    init(interactor: UserBusinessLogic, initialState: User.ViewControllerState = .initial) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func loadView() {
        let view = UserView()
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            display(newState: .initial)
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.bounds = view.safeAreaLayoutGuide.layoutFrame
    }
    
    // MARK: Init
    func initRequest() async {
        loadingRequest()
        await interactor.initRequest(request: User.Init.Request())
    }
    
    // MARK: Loading
    func loadingRequest(){
        interactor.loadingRequest(request: User.Loading.Request())
    }
    
    // MARK: Reload
    func reloadRequest(){
        interactor.reloadRequest(request: User.Reload.Request())
    }
}

extension UserViewController: UserDisplayLogic {
    func displaySomething(viewModel: User.Init.ViewModel) {
        display(newState: viewModel.state)
    }
    
    func displaySomething(viewModel: User.Loading.ViewModel) {
        display(newState: viewModel.state)
    }
    
    func displaySomething(viewModel: User.Reload.ViewModel) {
        display(newState: viewModel.state)
    }
    
    func displayUserInfo(viewModel: User.ShowUserInfo.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: User.ViewControllerState) {
        state = newState
        switch state {
        case .initial:
            Task {
                await  initRequest()
            }
        case let .setup(model):
            customView?.setup(with: model)
        case let .configure(model):
            customView?.configure(with: model)
        case .notAuthorized:
            self.router?.openViewController(toView: MyViewController.authentification)
        }
    }
}


extension UserViewController : UserRouterAppearance {
    
    func applyRouterSettigs() {
        let tabBarSetting  = TabBarSetting()
        tabBarItem = UITabBarItem(
            title: tabBarSetting.tabBarTitle,
            image: tabBarSetting.image,
            selectedImage: tabBarSetting.selectedImage)
        title = tabBarSetting.title
    }
    
    struct TabBarSetting {
        let tabBarTitle = String("профиль")
        let image = UIImage(systemName: "person")
        let selectedImage = UIImage(systemName: "person.fill")
        let title = "профиль"
    }
    
}


extension UserViewController: ErrorViewDelegate {
    func reloadButtonWasTapped() {
        self.customView?.stopError()
    }
}
