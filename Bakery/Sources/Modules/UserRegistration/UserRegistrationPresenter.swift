//
//  user registration logic
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

@MainActor
protocol UserRegistrationPresentationLogic {
    func presentRegistrationResult(response: UserRegistration.Registration.Response)
}

@MainActor
/// Отвечает за отображение данных модуля UserRegistration
class UserRegistrationPresenter: UserRegistrationPresentationLogic {
    weak var viewController: UserRegistrationDisplayLogic?

    // MARK: Do something
    func presentRegistrationResult(response: UserRegistration.Registration.Response) {
        var viewModel: UserRegistration.Registration.ViewModel
        
        switch response.result {
        case let .failure(error):
            viewModel = UserRegistration.Registration.ViewModel(state: .error(message: error.localizedDescription))
        case .success:
            viewModel = UserRegistration.Registration.ViewModel(state: .success)
        case .alreadyExists:
            viewModel = UserRegistration.Registration.ViewModel(state: .alreadyExists)
        }
        
        viewController?.displaySomething(viewModel: viewModel)
    }
}
