//
//  Отвечает за аутентификацию пользователя
//  Created by Елизавета Кравченкова on 10/04/2025.
//

import UIKit

protocol UserAutentificationDisplayLogic: AnyObject {
    func displayModule(viewModel: UserAutentification.ShowModule.ViewModel)
}

class UserAutentificationViewController: UIViewController {
    let interactor: UserAutentificationBusinessLogic
    var state: UserAutentification.ViewControllerState

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
        let view = UserAutentificationView(frame: UIScreen.main.bounds)
        self.view = view
        // make additional setup of view or save references to subviews
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showModule()
    }

    // MARK: Do something
    func showModule() {
        let request = UserAutentification.ShowModule.Request()
        interactor.showModule(request: request)
    }
}

extension UserAutentificationViewController: UserAutentificationDisplayLogic {
    func displaySomething(viewModel: UserAutentification.Something.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: UserAutentification.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            print("loading...")
        case let .error(message):
            print("error \(message)")
        case let .result(items):
            print("result: \(items)")
        case .emptyResult:
            print("empty result")
        }
    }
}


extension UserAutentificationViewController :ButtonDelegate {
    @objc func didTapLoginButton() {
        dismiss(animated: true, completion: nil)
    }
}
