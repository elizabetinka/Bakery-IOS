//
//  Отвечает за аутентификацию пользователя
//  Created by Елизавета Кравченкова on 10/04/2025.
//

import UIKit

protocol LoginButtonDelegate: AnyObject {
    func didTapLoginButton(number: String)
}

protocol UserAutentificationValidateDelegate: AnyObject {
    func validatePhoneNumber(number: String)
}

protocol UserAutentificationDisplayLogic: AnyObject {
    func displaySomething(viewModel: UserAutentification.Login.ViewModel)
}

class UserAutentificationViewController: UIViewController {
    let interactor: UserAutentificationBusinessLogic
    var state: UserAutentification.ViewControllerState
    weak var router: TabBarRouterProtocol?
    
    lazy var customView = self.view as? UserAutentificationViewProtocol
    

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
        let view = UserAutentificationView(frame: UIScreen.main.bounds,delegate: self, refreshDelegate: self, validateDelegate: self)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("UserAutentificationViewController.viewDidLoad")
    }

    // MARK: Do something
    func login(number : String) async {
        let request = UserAutentification.Login.Request(form: UserAutentification.UserAutentificationRequest(phoneNumner: number))
        await interactor.login(request: request)
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
            customView?.showLoading()
        case let .error(message):
            customView?.showError(message: message)
        case .success:
            self.dismiss(animated: true, completion: nil)
            router?.openViewController(toView: MyViewController.user)
        case .notRegistred:
            self.dismiss(animated: true, completion: nil)
            router?.openViewController(toView: MyViewController.registration)
        }
    }
}


extension UserAutentificationViewController : LoginButtonDelegate {
    func didTapLoginButton(number : String) {
        print("didTapLoginButton: \(number)")
        customView?.showLoading()
        Task {
            await login(number: number)
        }
    }
}

extension UserAutentificationViewController: ErrorViewDelegate {
    func reloadButtonWasTapped() {
        self.customView?.stopError()
    }
}

extension  UserAutentificationViewController: UserAutentificationValidateDelegate {
    func validatePhoneNumber(number: String) {
        let isValid = interactor.validatePhoneNumber(number: number)
        customView?.updateUI(isValid: isValid)
    }
}
