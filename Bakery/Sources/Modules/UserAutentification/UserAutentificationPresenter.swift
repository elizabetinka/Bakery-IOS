//
//  Отвечает за аутентификацию пользователя
//  Created by Елизавета Кравченкова on 10/04/2025.
//

import UIKit

@MainActor
protocol UserAutentificationPresentationLogic {
    func presentLoginResult(response: UserAutentification.Login.Response)
    func presentInitialData(response: UserAutentification.Init.Response)
    func presentLoadingData(response: UserAutentification.Loading.Response)
    func presentReloadData(response: UserAutentification.Reload.Response)
    func presentValidatedPhone(response: UserAutentification.ValidatePhoneNumber.Response)
}

@MainActor
/// Отвечает за отображение данных модуля UserAutentification
class UserAutentificationPresenter: UserAutentificationPresentationLogic {
    
    weak var viewController: UserAutentificationDisplayLogic?
    weak var buttonDelegate: LoginButtonDelegate?
    weak var refreshActionsDelegate: ErrorViewDelegate?
    weak var validateDelegate: UserAutentificationValidateDelegate?
    
    var vm: UserAutentificationViewModel?

    // MARK: present login result
    func presentLoginResult(response: UserAutentification.Login.Response) {
        var viewModel: UserAutentification.Login.ViewModel
        guard var vm = vm else { return }
        
        vm.activityIndicator?.state = .stopped
        
        switch response.result {
        case let .failure(error):
            vm.errorModel?.state = .error
            vm.errorModel?.title?.text = error
            
            viewModel = UserAutentification.Login.ViewModel(state: .configure(model: vm))
        case .success:
            viewModel=UserAutentification.Login.ViewModel(state: .success)
        case .notRegistred:
            viewModel=UserAutentification.Login.ViewModel(state: .notRegistred)
        }
        
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentInitialData(response: UserAutentification.Init.Response) {
        vm = getInitialViewModel()
        let viewModel = UserAutentification.Init.ViewModel(state: .setup(model: vm!))
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentLoadingData(response: UserAutentification.Loading.Response) {
        guard var vm = vm else { return }
        vm.activityIndicator?.state = .running
        let viewModel = UserAutentification.Loading.ViewModel(state: .configure(model: vm))
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentReloadData(response: UserAutentification.Reload.Response) {
        guard var vm = vm else { return }
        vm.errorModel?.state = .hidden
        let viewModel = UserAutentification.Reload.ViewModel(state: .configure(model: vm))
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    
    func presentValidatedPhone(response: UserAutentification.ValidatePhoneNumber.Response) {
        guard var vm = vm else { return }
       switch response.result {
            case .success:
            vm.phoneTextField?.state = .default
            vm.loginButton?.state = .default
            vm.phoneTextField?.errorLabel.state = .hidden
            vm.phoneTextField?.errorLabel.text = ""
                break
        case let .failure(error):
            vm.phoneTextField?.state = .error
            vm.phoneTextField?.errorLabel.text = error
            vm.phoneTextField?.errorLabel.state = .default
            vm.loginButton?.state = .disabled
        }
        let viewModel = UserAutentification.ValidatePhoneNumber.ViewModel(state: .configure(model: vm))
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    
    private func  getInitialViewModel() -> UserAutentificationViewModel {
        var model = UserAutentificationViewModel()
        
        let errorLabelLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .xs, HMargin: .m), padding: DSLayoutPadding())
        
        let phoneTextFieldLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .l, HMargin: .m), padding: DSLayoutPadding(VPadding: .s, HPadding: .m))
        
        var errorLabelTextField = DSLabelViewModel(text: "", style: .error, state: .hidden, size: .s, layout: errorLabelLayout)
        errorLabelTextField.identifier = "errorLabelTextField"
        
        model.phoneTextField = DSTextFieldViewModel(placeholder: "+7", layout: phoneTextFieldLayout, onEditingChanged: validateDelegate?.validatePhoneNumber, errorLabel: errorLabelTextField)
        
        model.phoneTextField?.identifier = "phoneTextField"
        
        let buttonLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, topMargin: .m), padding: DSLayoutPadding(VPadding: .xs, HPadding: .m))
        
        model.loginButton = DSButtonViewModel(title: "Войти", style: .primary, size: .medium, state: .default, layout: buttonLayout, onTap: buttonDelegate?.didTapLoginButton)
        model.loginButton?.identifier = "loginButton"
        
        model.errorModel = getInitialErrorViewModel()
        
        let titleLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .xxl, HMargin: .m), padding: DSLayoutPadding())
        
        model.titleLabel = DSLabelViewModel(text: "Введите номер телефона", style: .primary, state: .default, size: .m, layout: titleLayout)
        model.titleLabel?.identifier = "title"
        
        let activityIndicatorLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, vAlign: .center), padding: DSLayoutPadding())
        
        model.activityIndicator = DSActivityIndicatorViewModel(state: .stopped, size: .large, style: .primary, layout: activityIndicatorLayout)
        
        let imageLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, topMargin: .l), padding: DSLayoutPadding())
        
        model.logoImage = DSImageViewModel(image: UIImage.logo, size: .default, layout: imageLayout)
        
        let cpacerLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin:.zero,bottomMargin: .zero, HMargin: .m), padding: DSLayoutPadding())
        model.spacer = DSSpacerViewModel(layout: cpacerLayout, minHeight: VSpacing.s.rawValue)

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
