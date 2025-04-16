//
//  User actions module
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

protocol UserPresentationLogic {
    func presentModule(response: User.ShowModule.Response)
}

/// Отвечает за отображение данных модуля User
class UserPresenter: UserPresentationLogic {
    weak var viewController: UserDisplayLogic?

    // MARK: Do something
    func presentModule(response: User.ShowModule.Response) {
        var viewModel: User.ShowModule.ViewModel
        
        switch response.result {
        case let .failure(error):
            viewModel = User.ShowModule.ViewModel(state: .error(message: error.localizedDescription))
        case let .success(result):
            switch result.userStatus {
            case .isEntered(let userInfo):
                viewModel = User.ShowModule.ViewModel(state: .result(UserInfoViewModel(name: userInfo.name, points: userInfo.points, phoneNumber: userInfo.phoneNumber)))
            case .needAuth:
                viewModel = User.ShowModule.ViewModel(state: .auth)
            }
        }
        
        viewController?.displaySomething(viewModel: viewModel)
    }
}
