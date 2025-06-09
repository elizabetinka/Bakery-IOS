//
//  user registration logic
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

protocol RegistrationButtonDelegate: AnyObject {
    func didTapRegistrationButton()
}

protocol UserRegistrationDisplayLogic: AnyObject {
    func displaySomething(viewModel: UserRegistration.Registration.ViewModel)
    func displaySomething(viewModel: UserRegistration.Init.ViewModel)
    func displaySomething(viewModel: UserRegistration.ValidateName.ViewModel)
    func displaySomething(viewModel: UserRegistration.ValidatePhone.ViewModel)
    func displaySomething(viewModel: UserRegistration.Loading.ViewModel)
    func displaySomething(viewModel: UserRegistration.Reload.ViewModel)
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

    init(interactor: UserRegistrationBusinessLogic, initialState: UserRegistration.ViewControllerState = .initial) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func loadView() {
        let view = UserRegistrationView(frame: UIScreen.main.bounds)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        display(newState: state)
    }

    // MARK: registration
    func registration(number : String, name: String) async {
        loadingRequest()
        let request = UserRegistration.Registration.Request(form: UserRegistration.UserRegistrationRequest(phoneNumner: number, name: name))
        await interactor.registration(request: request)
    }
    
    func initRequest(){
        interactor.initRequest(request: UserRegistration.Init.Request())
    }
    
    func loadingRequest(){
        interactor.loadingRequest(request: UserRegistration.Loading.Request())
    }
    
    func reloadRequest(){
        interactor.reloadRequest(request: UserRegistration.Reload.Request())
    }
    
    func validateNameRequest(name: String){
        interactor.validateName(request: UserRegistration.ValidateName.Request(name: name))
    }
    
    func validatePhoneRequestPhone(number : String){
        interactor.validatePhone(request: UserRegistration.ValidatePhone.Request(phone: number))
    }
}

extension UserRegistrationViewController: UserRegistrationDisplayLogic {
    func displaySomething(viewModel: UserRegistration.Registration.ViewModel) {
        display(newState: viewModel.state)
    }
    func displaySomething(viewModel: UserRegistration.Init.ViewModel) {
        display(newState: viewModel.state)
    }
    func displaySomething(viewModel: UserRegistration.Reload.ViewModel) {
        display(newState: viewModel.state)
    }
    func displaySomething(viewModel: UserRegistration.Loading.ViewModel) {
        display(newState: viewModel.state)
    }
    func displaySomething(viewModel: UserRegistration.ValidateName.ViewModel) {
        display(newState: viewModel.state)
    }
    func displaySomething(viewModel: UserRegistration.ValidatePhone.ViewModel) {
        display(newState: viewModel.state)
    }
    
    func display(newState: UserRegistration.ViewControllerState) {
        state = newState
        switch state {
        case .initial:
            initRequest()
        case let .setup(model):
            customView?.setup(with: model)
        case let .configure(model):
            customView?.configure(with: model)
        case .success:
            dismiss(animated: true, completion: nil)
            router?.openViewController(toView: MyViewController.user)
        }
    }
}


extension UserRegistrationViewController : RegistrationButtonDelegate {    
    func didTapRegistrationButton() {
        let info = customView?.getInfo()
        let number = info?.phoneTextField.text ?? ""
        let name = info?.nameTextField.text ?? ""
        Task {
            await registration(number: number, name: name)
        }
    }
}

extension  UserRegistrationViewController: UserRegistrationValidateDelegate {
    
    func validateName(name: String) {
        validateNameRequest(name: name)
    }
    
    
    func validatePhoneNumber(number: String) {
        validatePhoneRequestPhone(number: number)
    }
    
}

extension UserRegistrationViewController: ErrorViewDelegate {
    func reloadButtonWasTapped() {
        reloadRequest()
    }
}
