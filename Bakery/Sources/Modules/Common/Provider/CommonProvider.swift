//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

protocol CommonProviderProtocol {
    func getImage(completion: @escaping (UIImage?, CommonProviderError?) -> Void)
}

enum CommonProviderError: Error {
    case getImageFailed(underlyingError: Error)
}

/// Отвечает за получение данных модуля Common
struct CommonProvider: CommonProviderProtocol {
    let dataStore: CommonDataStore
    let service: CommonServiceProtocol

    init(dataStore: CommonDataStore = CommonDataStore(), service: CommonServiceProtocol = CommonService()) {
        self.dataStore = dataStore
        self.service = service
    }

    func getImage(completion: @escaping (UIImage?, CommonProviderError?) -> Void) {
        if dataStore.images.isEmpty == false {
            return completion(self.dataStore.images[0], nil)
        }
        service.fetchImages { (image, error) in
            if let error = error {
                completion(nil, .getImageFailed(underlyingError: error))
            } else if let image = image {
                self.dataStore.images.append(image)
                completion(self.dataStore.images[0], nil)
            }
        }
    }
}
