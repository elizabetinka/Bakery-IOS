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

class UserRegistrationViewController: UIViewController {
    let interactor: UserRegistrationBusinessLogic
    var state: UserRegistration.ViewControllerState
    
    weak var router: TabBarRouterProtocol?
    
    lazy var customView = self.view as? UserRegistrationView

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
        let view = UserRegistrationView(frame: UIScreen.main.bounds, delegate: self, refreshDelegate: self)
        self.view = view
        // make additional setup of view or save references to subviews
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("UserRegistrationViewController.viewDidLoad")
        display(newState: state)
    }

    // MARK: registration
    func registration(number : String, name: String) {
        let request = UserRegistration.Registration.Request(form: UserRegistration.UserRegistrationRequest(phoneNumner: number, name: name))
        interactor.registration(request: request)
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
            print("loading...")
            customView?.showLoading()
        case let .error(message):
            print("error \(message)")
            customView?.showError(message: message)
            dismiss(animated: true, completion: nil)
            router?.openViewController(toView: MyViewController.home)
            
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
        registration(number: number, name: name)
    }
}
