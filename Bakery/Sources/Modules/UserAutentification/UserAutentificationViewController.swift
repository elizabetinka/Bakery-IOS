//
//  Отвечает за аутентификацию пользователя
//  Created by Елизавета Кравченкова on 10/04/2025.
//

import UIKit

protocol LoginButtonDelegate: AnyObject {
    func didTapLoginButton()
}

protocol UserAutentificationValidateDelegate: AnyObject {
    func validatePhoneNumber(number: String)
}

protocol UserAutentificationDisplayLogic: AnyObject {
    func displaySomething(viewModel: UserAutentification.Login.ViewModel)
    func displaySomething(viewModel: UserAutentification.Init.ViewModel)
    func displaySomething(viewModel: UserAutentification.ValidatePhoneNumber.ViewModel)
    func displaySomething(viewModel: UserAutentification.Loading.ViewModel)
    func displaySomething(viewModel: UserAutentification.Reload.ViewModel)
}

class UserAutentificationViewController: UIViewController {
    let interactor: UserAutentificationBusinessLogic
    var state: UserAutentification.ViewControllerState
    weak var router: TabBarRouterProtocol?
    
    lazy var customView = self.view as? UserAutentificationViewProtocol
    

    init(interactor: UserAutentificationBusinessLogic, initialState: UserAutentification.ViewControllerState = .initial) {
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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("UserAutentificationViewController.viewDidLoad")
        display(newState: state)
    }

    // MARK: Do something
    func login(number : String) async {
        loadingRequest()
        let request = UserAutentification.Login.Request(form: UserAutentification.UserAutentificationRequest(phoneNumner: number))
        await interactor.login(request: request)
    }
    
    func initRequest(){
        interactor.initRequest(request: UserAutentification.Init.Request())
    }
    
    func loadingRequest(){
        interactor.loadingRequest(request: UserAutentification.Loading.Request())
    }
    
    func reloadRequest(){
        interactor.reloadRequest(request: UserAutentification.Reload.Request())
    }
    
    func validateRequest(number : String){
        interactor.validatePhoneNumber(request: UserAutentification.ValidatePhoneNumber.Request(form: UserAutentification.UserAutentificationRequest(phoneNumner: number)))
    }
}

extension UserAutentificationViewController: UserAutentificationDisplayLogic {
    func displaySomething(viewModel: UserAutentification.Login.ViewModel) {
        display(newState: viewModel.state)
    }
    func displaySomething(viewModel: UserAutentification.Init.ViewModel) {
        display(newState: viewModel.state)
    }
    func displaySomething(viewModel: UserAutentification.ValidatePhoneNumber.ViewModel) {
        display(newState: viewModel.state)
    }
    func displaySomething(viewModel: UserAutentification.Loading.ViewModel) {
        display(newState: viewModel.state)
    }
    func displaySomething(viewModel: UserAutentification.Reload.ViewModel) {
        display(newState: viewModel.state)
    }
    
    func display(newState: UserAutentification.ViewControllerState) {
        state = newState
        switch state {
        case .initial:
            initRequest()
        case let .setup(model):
            customView?.setup(with: model)
        case let .configure(model):
            customView?.configure(with: model)
//        case .loading:
//            loadingRequest()
//        case let .error(message):
//            customView?.showError(message: message)
        case .success:
            self.dismiss(animated: true, completion: nil)
            router?.openViewController(toView: MyViewController.user)
        case .notRegistred:
            print(".notRegistred")
            self.dismiss(animated: true, completion: nil)
            router?.openViewController(toView: MyViewController.registration)
        }
    }
}


extension UserAutentificationViewController : LoginButtonDelegate {
    func didTapLoginButton() {
        let info = customView?.getInfo()
        let number = info?.phoneTextField.text ?? ""
        print("didTapLoginButton: \(number)")
        //customView?.showLoading()
        Task {
            await login(number: number)
        }
    }
}

extension UserAutentificationViewController: ErrorViewDelegate {
    func reloadButtonWasTapped() {
        print("reloadButtonWasTapped")
        reloadRequest()
    }
}

extension  UserAutentificationViewController: UserAutentificationValidateDelegate {
    func validatePhoneNumber(number: String) {
        validateRequest(number: number)
    }
}
