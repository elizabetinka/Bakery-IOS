//
//  User actions module
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

protocol UserDisplayLogic: AnyObject {
    func displayUserInfo(viewModel: User.ShowUserInfo.ViewModel)
}

protocol UserRouterAppearance: AnyObject {
    func applyRouterSettigs()
}

class UserViewController: UIViewController {
    let interactor: UserBusinessLogic
    var state: User.ViewControllerState
    weak var router: TabBarRouterProtocol?
    lazy var customView = self.view as? UserView

    init(interactor: UserBusinessLogic, initialState: User.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func loadView() {
        print("Loading User view")
        let view = UserView(refreshDelegate: self)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("UserViewController viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            print("UserViewController viewWillAppear")
            display(newState: .loading)
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.bounds = view.safeAreaLayoutGuide.layoutFrame
    }

    // MARK: Do something
    func showUserInfo() async {
        let request = User.ShowUserInfo.Request()
        await interactor.showUserInfo(request: request)
    }
}

extension UserViewController: UserDisplayLogic {
    func displayUserInfo(viewModel: User.ShowUserInfo.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: User.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            self.customView?.showLoading()
            Task {
                await showUserInfo()
            }
        case let .error(message):
            self.customView?.showError(message: message)
        case let .result(info):
            self.customView?.presentUserInfo(userInfo: info)
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
