//
//  Отвечает за аутентификацию пользователя
//  Created by Елизавета Кравченкова on 10/04/2025.
//

import UIKit

protocol UserAutentificationPresentationLogic {
    func presentSomething(response: UserAutentification.Something.Response)
}

/// Отвечает за отображение данных модуля UserAutentification
class UserAutentificationPresenter: UserAutentificationPresentationLogic {
    weak var viewController: UserAutentificationDisplayLogic?

    // MARK: Do something
    func presentSomething(response: UserAutentification.Something.Response) {
        var viewModel: UserAutentification.Something.ViewModel
        
        switch response.result {
        case let .failure(error):
            viewModel = UserAutentification.Something.ViewModel(state: .error(message: error.localizedDescription))
        case let .success(result):
            if result.isEmpty {
                viewModel = UserAutentification.Something.ViewModel(state: .emptyResult)
            } else {
                viewModel = UserAutentification.Something.ViewModel(state: .result(result))
            }
        }
        
        viewController?.displaySomething(viewModel: viewModel)
    }
}
