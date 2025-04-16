//
//  item details
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

protocol MenuDetailsPresentationLogic {
    func presentItemDetails(response: MenuDetails.ShowDetails.Response)
}

/// Отвечает за отображение данных модуля MenuDetails
class MenuDetailsPresenter: MenuDetailsPresentationLogic {
    weak var viewController: MenuDetailsDisplayLogic?

    // MARK: Do something
    func presentItemDetails(response: MenuDetails.ShowDetails.Response) {
        var viewModel: MenuDetails.ShowDetails.ViewModel
        
        switch response.result {
        case let .failure(error):
            viewModel = MenuDetails.ShowDetails.ViewModel(state: .error(message: error.localizedDescription))
        case let .success(result):
            let detailsViewModel = MenuDetailsViewModel(uid: result.uid, name: result.name, cost: result.cost, kcal: result.kcal, description: result.description, itemImage: result.itemImage)
            viewModel = MenuDetails.ShowDetails.ViewModel(state: .result(detailsViewModel))
        case .notExists:
            viewModel = MenuDetails.ShowDetails.ViewModel(state: .emptyResult)
        }
        
        viewController?.presentItemDetails(viewModel: viewModel)
    }
}
