//
//  Отвечает за логику главного экрана
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

protocol CommonPresentationLogic {
    func presentUserInfo(response: Common.ShowUserInfo.Response)
    func presentItem(response: Common.ShowItem.Response)
}

/// Отвечает за отображение данных модуля Common
class CommonPresenter: CommonPresentationLogic {
    weak var viewController: CommonDisplayLogic?

    // MARK: Do something
    func presentUserInfo(response: Common.ShowUserInfo.Response) {
        var viewModel: Common.ShowUserInfo.ViewModel
        
        switch response.result {
        case let .failure(error):
            viewModel = Common.ShowUserInfo.ViewModel(state: .error(message: error.localizedDescription))
        case let .success(result):
            let model = CommonUserViewModel(name: result.name, points: result.points)
            viewModel = Common.ShowUserInfo.ViewModel(state: .authorizedResult(model))
        case .notAuthorized:
            viewModel = Common.ShowUserInfo.ViewModel(state: .notAuthorized)
        }
        
        viewController?.displayUserInfo(viewModel: viewModel)
    }
    
    func presentItem(response: Common.ShowItem.Response) {
        var viewModel: Common.ShowItem.ViewModel
        
        switch response.result {
        case let .failure(error):
            viewModel = Common.ShowItem.ViewModel(state: .error(message: error.localizedDescription))
        case let .success(result):
            let model = CommonItemViewModel(menuImage: result.itemImage)
            viewModel = Common.ShowItem.ViewModel(state: .result(model))
        case .emptyResult:
            viewModel = Common.ShowItem.ViewModel(state: .emptyResult)
        }
        
        viewController?.displayItem(viewModel: viewModel)
    }
}
