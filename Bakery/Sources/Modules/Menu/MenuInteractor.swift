//
//  menu logic
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

protocol MenuBusinessLogic {
    func fetchItems(request: Menu.ShowItems.Request) async
}

/// Класс для описания бизнес-логики модуля Menu
class MenuInteractor: MenuBusinessLogic {
    let presenter: MenuPresentationLogic
    let provider: MenuProviderProtocol

    init(presenter: MenuPresentationLogic, provider: MenuProviderProtocol = MenuProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: fetch items
    func fetchItems(request: Menu.ShowItems.Request) async {
        let (items, error)  = await provider.getItems ()
        
        let result: Menu.MenuRequestResult
        if let items = items {
            result = .success(items)
        } else if let error = error {
            switch error {
            case .getMenuFailed(_):
                result = .failure(.someError(message: error.localizedDescription))
            default:
                result = .failure(.someError(message: "No Data"))
            }
        } else {
            result = .failure(.someError(message: "No Data"))
        }
        await self.presenter.presentItems(response: Menu.ShowItems.Response(result: result))
}
}
