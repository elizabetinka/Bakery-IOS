//
//  Отвечает за аутентификацию пользователя
//  Created by Елизавета Кравченкова on 10/04/2025.
//

import UIKit

protocol LoginButtonDelegate: AnyObject {
    func didTapLoginButton(number: String)
}

protocol UserAutentificationDisplayLogic: AnyObject {
    func displaySomething(viewModel: UserAutentification.Login.ViewModel)
}

class UserAutentificationViewController: UIViewController {
    let interactor: UserAutentificationBusinessLogic
    var state: UserAutentification.ViewControllerState
    weak var router: TabBarRouterProtocol?
    
    lazy var customView = self.view as? UserAutentificationView
    

    init(interactor: UserAutentificationBusinessLogic, initialState: UserAutentification.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func loadView() {
        let view = UserAutentificationView(frame: UIScreen.main.bounds,delegate: self)
        self.view = view
        // make additional setup of view or save references to subviews
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("UserAutentificationViewController.viewDidLoad")
        display(newState: state)
    }

    // MARK: Do something
    func login(number : String) {
        let request = UserAutentification.Login.Request(form: UserAutentification.UserAutentificationRequest(phoneNumner: number))
        interactor.login(request: request)
    }
}

extension UserAutentificationViewController: UserAutentificationDisplayLogic {
    func displaySomething(viewModel: UserAutentification.Login.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: UserAutentification.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            print("loading...")
            customView?.showLoading()
        case let .error(message):
            print("error \(message)")
            customView?.showError(message: message)
        case .success:
            dismiss(animated: true, completion: nil)
            router?.openViewController(toView: MyViewController.user)
        case .notRegistred:
            dismiss(animated: true, completion: nil)
            router?.openViewController(toView: MyViewController.registration)
        }
    }
}


extension UserAutentificationViewController : LoginButtonDelegate {
    func didTapLoginButton(number : String) {
        login(number: number)
        //dismiss(animated: true, completion: nil)
    }
}
