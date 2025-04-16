//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

protocol MenuServiceProtocol {
    func fetchItems(completion: @escaping ([ItemModel]?, MenuServiceError?) -> Void)
    func fetchItem(by id: UniqueIdentifier, completion: @escaping (ItemModel?, MenuServiceError?) -> Void)
}

enum MenuServiceError: Error {
    case getUserFailed(underlyingError: Error)
    case notExists
}

/// Получает данные для модуля Menu
class MenuService: MenuServiceProtocol {
    static let shared = MenuService()
    private init() {}
    
    private var lastId : UniqueIdentifier = 0;
    private var items: [ItemModel] = [ItemModel(uid: 0, name: "Елизавета Кравченкова", cost: 1000, kcal: 0, description: "cake", itemImage: UIImage())]
    
    func fetchItems(completion: @escaping ([ItemModel]?, MenuServiceError?) -> Void) {
        completion(items, nil)
    }
    func fetchItem(by id: UniqueIdentifier, completion: @escaping (ItemModel?, MenuServiceError?) -> Void) {
        if let item = items.first(where: { $0.uid == id }) {
            completion(item, nil)
            return
        }

        completion(nil, .notExists)
    }
}
