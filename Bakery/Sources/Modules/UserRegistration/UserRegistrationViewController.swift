//
//  user registration logic
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

protocol RegistrationButtonDelegate: AnyObject {
    func didTapRegistrationButton(number: String, name: String)
}

protocol UserRegistrationDisplayLogic: AnyObject {
    func displaySomething(viewModel: UserRegistration.Registration.ViewModel)
}

protocol UserRegistrationValidateDelegate: AnyObject {
    func validatePhoneNumber(number: String)
    func validateName(name: String)
}

class UserRegistrationViewController: UIViewController {
    let interactor: UserRegistrationBusinessLogic
    var state: UserRegistration.ViewControllerState
    
    weak var router: TabBarRouterProtocol?
    
    lazy var customView = self.view as? UserRegistrationViewProtocol

    init(interactor: UserRegistrationBusinessLogic, initialState: UserRegistration.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func loadView() {
        let view = UserRegistrationView(frame: UIScreen.main.bounds, delegate: self, refreshDelegate: self, validateDelegate: self)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("UserRegistrationViewController.viewDidLoad")
    }

    // MARK: registration
    func registration(number : String, name: String) async {
        let request = UserRegistration.Registration.Request(form: UserRegistration.UserRegistrationRequest(phoneNumner: number, name: name))
        await interactor.registration(request: request)
    }
}

extension UserRegistrationViewController: UserRegistrationDisplayLogic {
    func displaySomething(viewModel: UserRegistration.Registration.ViewModel) {
        display(newState: viewModel.state)
    }
    
    func display(newState: UserRegistration.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            customView?.showLoading()
        case let .error(message):
            customView?.showError(message: message)
        case .success:
            dismiss(animated: true, completion: nil)
            router?.openViewController(toView: MyViewController.user)
        case .alreadyExists:
            customView?.showError(message: "Такой номер уже зарегистрирован")
        }
    }
}


extension UserRegistrationViewController : RegistrationButtonDelegate {    
    func didTapRegistrationButton(number : String, name: String) {
        customView?.showLoading()
        Task {
            await registration(number: number, name: name)
        }
    }
}

extension  UserRegistrationViewController: UserRegistrationValidateDelegate {
    func validateName(name: String) {
        let isValid = interactor.validateName(name: name)
        customView?.validatedName(isValid: isValid)
    }
    
    func validatePhoneNumber(number: String) {
        let isValid = interactor.validatePhoneNumber(number: number)
        customView?.validatedPhone(isValid: isValid)
    }
}

extension UserRegistrationViewController: ErrorViewDelegate {
    func reloadButtonWasTapped() {
        customView?.stopError()
    }
}
