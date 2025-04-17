//
//  User actions module
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

protocol UserPresentationLogic {
    func presentUserInfo(response: User.ShowUserInfo.Response)
}

/// Отвечает за отображение данных модуля User
class UserPresenter: UserPresentationLogic {
    weak var viewController: UserDisplayLogic?

    // MARK: Do something
    func presentUserInfo(response: User.ShowUserInfo.Response) {
        var viewModel: User.ShowUserInfo.ViewModel
        
        switch response.result {
        case let .failure(error):
            viewModel = User.ShowUserInfo.ViewModel(state: .error(message: error.localizedDescription))
        case let .success(result):
            let userInfo = UserInfoViewModel(name: result.name, points: result.points, phoneNumber: result.phoneNumner)
            viewModel = User.ShowUserInfo.ViewModel(state: .result(userInfo))
        case .notAuthorized:
            viewModel = User.ShowUserInfo.ViewModel(state: .notAuthorized)
        }
        
        viewController?.displayUserInfo(viewModel: viewModel)
    }
}
