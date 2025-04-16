//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

protocol CommonServiceProtocol {
    func fetchImages(completion: @escaping (UIImage?, Error?) -> Void)
}

/// Получает данные для модуля Common
class CommonService: CommonServiceProtocol {

    func fetchImages(completion: @escaping (UIImage?, Error?) -> Void) {
        completion(nil, nil)
    }
}
