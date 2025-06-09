//
//  Created by Елизавета Кравченкова on 10/04/2025.
//

import Foundation

protocol UniversalProviderProtocol {
    func getInitData(config: UniversalScreenConfig) async -> (Data?, UniversalProviderError?)
    
    func getCacheData(config: UniversalScreenConfig) -> Data?
}

enum UniversalProviderError: Error {
    case getDataFailed(underlyingError: Error)
    case unknown
}

extension UniversalProviderError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .getDataFailed(underlyingError):
            return NSLocalizedString(underlyingError.localizedDescription, comment: "")
        case .unknown:
            return NSLocalizedString("Неизвестная ошибка", comment: "")
        }
    }
}

/// Отвечает за получение данных модуля Universal
struct UniversalProvider: UniversalProviderProtocol {
    let dataStore: BDUICasheStoreProtocol
    let service: BDUIServiceProtocol

    init(dataStore: BDUICasheStoreProtocol = BDUICasheStore.shared, service: BDUIServiceProtocol = BDUIService.shared) {
        self.dataStore = dataStore
        self.service = service
    }
    
    func getInitData(config: UniversalScreenConfig) async -> (Data?, UniversalProviderError?){
        
        let (data, error) = await service.getData(endpoint: config.endpoint, key: config.key)
        
        if let error = error {
            let cashData = self.dataStore.getData(endpoint: config.endpoint, key: config.key)
            if let cashData = cashData {
                return (cashData, nil)
            }
            return (nil, .getDataFailed(underlyingError: error))
        } else if let data = data {
            self.dataStore.saveData(endpoint: config.endpoint, key: config.key, data: data)
            return (data, nil)
        }
        else{
            return (nil, .unknown)
        }
    }
        
    func getCacheData(config: UniversalScreenConfig) -> Data? {
        dataStore.getData(endpoint: config.endpoint, key: config.key)
    }
}
