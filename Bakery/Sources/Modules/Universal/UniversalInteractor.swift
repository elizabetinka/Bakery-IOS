//
//  Отвечает за универсальный экран для bd ui
//  Created by Елизавета Кравченкова on 20/05/2025.
//

protocol UniversalBusinessLogic {
    @MainActor func casheRequest(request: Universal.Cashe.Request)
    func initRequest(request: Universal.Init.Request) async
}

/// Класс для описания бизнес-логики модуля Universal
class UniversalInteractor: UniversalBusinessLogic {
    let presenter: UniversalPresentationLogic
    let provider: UniversalProviderProtocol
    

    init(presenter: UniversalPresentationLogic, provider: UniversalProviderProtocol = UniversalProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    @MainActor func casheRequest(request: Universal.Cashe.Request) {
        var result:  Universal.UniversalResult
        var data = provider.getCacheData(config: request.config)
        if let data = data {
            result = .success(data: data)
        }
        else {
            result = .failure(message: "cashe not have Data")
        }
        self.presenter.presentCasheData(response: Universal.Cashe.Response(result: result))
    }
    
    
    func initRequest(request: Universal.Init.Request) async {
        
        var result:  Universal.UniversalResult
        
        let (data, error) = await provider.getInitData(config: request.config)
        
        if let error = error {
            switch error {
            case .getDataFailed(_):
                result = .failure(message: error.localizedDescription)
            case .unknown:
                result = .failure(message: "No Data")
            }
        }
        else if let data = data {
            result = .success(data: data)
        }
        else {
            result = .failure(message: "No Data")
        }
        await self.presenter.presentInitialData(response: Universal.Init.Response(result: result))
    }
    
}
