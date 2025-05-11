//
//  user registration logic
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

@MainActor
protocol UserRegistrationPresentationLogic {
    func presentRegistrationResult(response: UserRegistration.Registration.Response)
    func presentInitialData(response: UserRegistration.Init.Response)
    func presentLoadingData(response: UserRegistration.Loading.Response)
    func presentReloadData(response: UserRegistration.Reload.Response)
    func presentValidatedName(response: UserRegistration.ValidateName.Response)
    func presentValidatedPhone(response: UserRegistration.ValidatePhone.Response)
}

@MainActor
/// Отвечает за отображение данных модуля UserRegistration
class UserRegistrationPresenter: UserRegistrationPresentationLogic {
    weak var viewController: UserRegistrationDisplayLogic?
    weak var buttonDelegate: RegistrationButtonDelegate?
    weak var refreshActionsDelegate: ErrorViewDelegate?
    weak var validateDelegate: UserRegistrationValidateDelegate?
    
    lazy var vm: UserRegistrationViewModel = getInitialViewModel()

    // MARK: Do something
    func presentRegistrationResult(response: UserRegistration.Registration.Response) {
        var viewModel: UserRegistration.Registration.ViewModel
        
        vm.activityIndicator?.state = .stopped
        
        switch response.result {
        case let .failure(error):
            
            vm.errorModel?.state = .error
            vm.errorModel?.title?.text = error
            
            viewModel = UserRegistration.Registration.ViewModel(state: .configure(model: vm))
        case .success:
            viewModel = UserRegistration.Registration.ViewModel(state: .success)
        case .alreadyExists:
            vm.errorModel?.state = .error
            vm.errorModel?.title?.text = "Такой номер уже зарегистрирован"
            
            viewModel = UserRegistration.Registration.ViewModel(state: .configure(model: vm))
        }
        
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    
    func presentInitialData(response: UserRegistration.Init.Response) {
        vm = getInitialViewModel()
        let viewModel = UserRegistration.Init.ViewModel(state: .setup(model: vm))
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentLoadingData(response: UserRegistration.Loading.Response) {
        vm.activityIndicator?.state = .running
        let viewModel = UserRegistration.Loading.ViewModel(state: .configure(model: vm))
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentReloadData(response: UserRegistration.Reload.Response) {
        vm.errorModel?.state = .hidden
        let viewModel = UserRegistration.Reload.ViewModel(state: .configure(model: vm))
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    
    func presentValidatedPhone(response: UserRegistration.ValidatePhone.Response) {
        switch response.result {
            case .success:
            vm.phoneTextField?.state = .default
            vm.button?.state = .default
            vm.phoneTextField?.errorLabel.state = .hidden
            vm.phoneTextField?.errorLabel.text = ""
                break
        case let .failure(error):
            vm.phoneTextField?.state = .error
            vm.phoneTextField?.errorLabel.text = error
            vm.phoneTextField?.errorLabel.state = .default
            vm.button?.state = .disabled
        }
        
        let viewModel = UserRegistration.ValidatePhone.ViewModel(state: .configure(model: vm))
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentValidatedName(response: UserRegistration.ValidateName.Response) {
        
        switch response.result {
             case .success:
             vm.nameTextField?.state = .default
             vm.button?.state = .default
             vm.nameTextField?.errorLabel.state = .hidden
             vm.nameTextField?.errorLabel.text = ""
                 break
         case let .failure(error):
             vm.nameTextField?.state = .error
             vm.nameTextField?.errorLabel.text = error
             vm.nameTextField?.errorLabel.state = .default
             vm.button?.state = .disabled
         }
        
        let viewModel = UserRegistration.ValidateName.ViewModel(state: .configure(model: vm))
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    
    private func  getInitialViewModel() -> UserRegistrationViewModel {
        var model = UserRegistrationViewModel()
        
        
        let imageLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, topMargin: .l), padding: DSLayoutPadding())
        
        model.logoImage = DSImageViewModel(image: UIImage.logo, size: .default, layout: imageLayout)
        
        let titleLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .l, HMargin: .m), padding: DSLayoutPadding())
        
        model.titleLabel = DSLabelViewModel(text: "Регистрация", style: .primary, state: .default, size: .l, layout: titleLayout)
        model.titleLabel?.identifier = "title"
        
        let nameLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .l, HMargin: .m), padding: DSLayoutPadding())
        
        model.nameLabel = DSLabelViewModel(text: "Введите имя", style: .primary, state: .default, size: .m, layout: nameLayout)
        model.nameLabel?.identifier = "nameLabel"
        
        let errorLabelLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .xs, HMargin: .l), padding: DSLayoutPadding())
        
        var errorLabelTextField = DSLabelViewModel(text: "", style: .error, state: .hidden, size: .s, layout: errorLabelLayout)
        errorLabelTextField.identifier = "errorLabelTextField"
        
        let nameTextFieldLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .xs, HMargin: .l), padding: DSLayoutPadding(VPadding: .s, HPadding: .m))
        
        model.nameTextField = DSTextFieldViewModel(placeholder: "", layout: nameTextFieldLayout, onEditingChanged: validateDelegate?.validateName, errorLabel: errorLabelTextField)
        model.nameTextField?.identifier = "nameTextField"
        
        let phoneLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .m, HMargin: .m), padding: DSLayoutPadding())
        
        model.phoneLabel = DSLabelViewModel(text: "Введите номер телефона", style: .primary, state: .default, size: .m, layout: phoneLayout)
        model.phoneLabel?.identifier = "phoneLabel"
        
        let phoneTextFieldLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .xs, HMargin: .l), padding: DSLayoutPadding(VPadding: .s, HPadding: .m))
        
        model.phoneTextField = DSTextFieldViewModel(placeholder: "+7", layout: phoneTextFieldLayout, onEditingChanged: validateDelegate?.validatePhoneNumber, errorLabel: errorLabelTextField)
        model.phoneTextField?.identifier = "phoneTextField"
        
        let buttonLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, topMargin: .l), padding: DSLayoutPadding(VPadding: .xs, HPadding: .m))
        
        model.button = DSButtonViewModel(title: "Зарегистрироваться", style: .primary, size: .medium, state: .default, layout: buttonLayout, onTap: buttonDelegate?.didTapRegistrationButton)
        model.button?.identifier = "registrationButton"
        
        let cpacerLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin:.zero,bottomMargin: .zero, HMargin: .m), padding: DSLayoutPadding())
        model.spacer = DSSpacerViewModel(layout: cpacerLayout, minHeight: VSpacing.s.rawValue)
        
        model.errorModel = getInitialErrorViewModel()
        
        
        let activityIndicatorLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, vAlign: .center), padding: DSLayoutPadding())
        
        model.activityIndicator = DSActivityIndicatorViewModel(state: .stopped, size: .large, style: .primary, layout: activityIndicatorLayout)
        
        return model
        
    }
    
    private func getInitialErrorViewModel() -> ErrorViewModel {
        var errorModel = ErrorViewModel()
        
        let buttonLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, topMargin: .l, bottomMargin: .s), padding: DSLayoutPadding(VPadding: .xs, HPadding: .m))
        
        errorModel.refreshButton = DSButtonViewModel(title: "Try again", style: .neutral, size: .medium, state: .default,layout: buttonLayout, onTap: refreshActionsDelegate?.reloadButtonWasTapped)
        errorModel.refreshButton?.identifier = "refreshButton"
        
        let titleLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .m, HMargin: .l), padding: DSLayoutPadding())
        
        errorModel.title = DSLabelViewModel(text: "Uncnown error", style: .primary, state: .default, size: .m, layout: titleLayout)
        errorModel.title?.identifier = "errorLabel"
        
        errorModel.layout = DSLayout(margin: DSLayoutMarging(width: .fill, hAlign: .center, vAlign: .center, HMargin: .xl))

        return errorModel
    }
}
