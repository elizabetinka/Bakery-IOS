//
//  Отвечает за аутентификацию пользователя
//  Created by Елизавета Кравченкова on 10/04/2025.
//

import UIKit

@MainActor
protocol UniversalPresentationLogic {
    func presentInitialData(response: Universal.Init.Response)
    func presentCasheData(response: Universal.Cashe.Response)
}

@MainActor
/// Отвечает за отображение данных модуля Universal
class UniversalPresenter: UniversalPresentationLogic {

    weak var viewController: UniversalDisplayLogic?
    weak var delegate: UniversalDelegate?
    
    let decoder = JSONDecoder()
    
    func presentCasheData(response: Universal.Cashe.Response) {
        var viewModel: Universal.Cashe.ViewModel
        delegate?.registerHandlers()
        
        switch response.result {
        case let .failure(error):
            let labelLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .l, HMargin: .m))
            let label = DSLabelViewModel(text: "\(error)", layout: labelLayout)
            viewModel = Universal.Cashe.ViewModel(state: .setup(model: .init(components: [label])))
        case let .success(data):
            do {
                let vm = try decoder.decode(UniversalViewModel.self, from: data)
                viewModel = Universal.Cashe.ViewModel(state:.setup(model: vm))
            }
            catch {
                let labelLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .l, HMargin: .m))
                let label = DSLabelViewModel(text: "в данном случае может быть ошибка сети", layout: labelLayout)
                viewModel = Universal.Cashe.ViewModel(state: .setup(model: .init(components: [label])))
            }
        }
        
        viewController?.displaySomething(viewModel: viewModel)
    }

    func presentInitialData(response: Universal.Init.Response) {
        var viewModel: Universal.Init.ViewModel
        delegate?.registerHandlers()
        
        switch response.result {
        case let .failure(error):
            let label = DSLabelViewModel(text: "\(error)")
            viewModel = Universal.Init.ViewModel(state: .setup(model: .init(components: [label])))
        case let .success(data):
            do {
                let vm = try decoder.decode(UniversalViewModel.self, from: data)
                viewModel = Universal.Init.ViewModel(state:.setup(model: vm))
            }
            catch {
                let label = DSLabelViewModel(text: "в данном случае может быть ошибка сети")
                viewModel = Universal.Init.ViewModel(state: .setup(model: .init(components: [label])))
            }
        }
        
        viewController?.displaySomething(viewModel: viewModel)
    }
    }
