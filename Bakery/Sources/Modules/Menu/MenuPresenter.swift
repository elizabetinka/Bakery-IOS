//
//  menu logic
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

@MainActor
protocol MenuPresentationLogic {
    func presentItems(response: Menu.ShowItems.Response)
}

@MainActor
/// Отвечает за отображение данных модуля Menu
class MenuPresenter: MenuPresentationLogic {
    weak var viewController: MenuDisplayLogic?

    // MARK: Do something
    func presentItems(response: Menu.ShowItems.Response) {
        var viewModel: Menu.ShowItems.ViewModel
        
        switch response.result {
        case let .failure(error):
            viewModel = Menu.ShowItems.ViewModel(state: .error(message: error.localizedDescription))
        case let .success(result):
            if result.isEmpty {
                viewModel = Menu.ShowItems.ViewModel(state: .emptyResult)
            } else {
                let viewModels = result.map { ItemViewModel(uid: $0.uid, name: $0.name, cost: $0.cost, itemImage: $0.itemImage) }
                viewModel = Menu.ShowItems.ViewModel(state: .result(viewModels))
            }
        }
        
        viewController?.displayItems(viewModel: viewModel)
    }
}
