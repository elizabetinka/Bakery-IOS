//
//  Отвечает за аутентификацию пользователя
//  Created by Елизавета Кравченкова on 10/04/2025.
//

import UIKit

protocol UserAutentificationPresentationLogic {
    func presentLoginResult(response: UserAutentification.Login.Response)
}

/// Отвечает за отображение данных модуля UserAutentification
class UserAutentificationPresenter: UserAutentificationPresentationLogic {
    weak var viewController: UserAutentificationDisplayLogic?

    // MARK: present login result
    func presentLoginResult(response: UserAutentification.Login.Response) {
        var viewModel: UserAutentification.Login.ViewModel
        
        switch response.result {
        case let .failure(error):
            viewModel = UserAutentification.Login.ViewModel(state: .error(message: error.localizedDescription))
        case .success:
            viewModel=UserAutentification.Login.ViewModel(state: .success)
        case .notRegistred:
            viewModel=UserAutentification.Login.ViewModel(state: .notRegistred)
        }
        
        viewController?.displaySomething(viewModel: viewModel)
    }
}
