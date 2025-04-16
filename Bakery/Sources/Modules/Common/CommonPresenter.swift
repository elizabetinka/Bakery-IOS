//
//  Отвечает за логику главного экрана
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

protocol CommonPresentationLogic {
    func presentModule(response: Common.ShowModule.Response)
}

/// Отвечает за отображение данных модуля Common
class CommonPresenter: CommonPresentationLogic {
    weak var viewController: CommonDisplayLogic?

    // MARK: Do something
    func presentModule(response: Common.ShowModule.Response) {
        var viewModel: Common.ShowModule.ViewModel
        
        switch response.result {
        case let .failure(error):
            viewModel = Common.ShowModule.ViewModel(state: .error(message: error.localizedDescription))
        case let .success(result):
            
            if let unwrapped = result.userInfo {
                let info = CommonViewModel.UserInfo(name: unwrapped.name, points: unwrapped.points)
                let ans = CommonViewModel(userInfo: info, menuImage: result.menuImage)
                viewModel = Common.ShowModule.ViewModel(state: .notAuthorizedResult(ans))
            } else {
                let ans = CommonViewModel(userInfo: nil, menuImage: result.menuImage)
                viewModel = Common.ShowModule.ViewModel(state: .authorizedResult(ans))
            }
        }
        
        viewController?.displayModule(viewModel: viewModel)
    }
}
