//
//  Created by Елизавета Кравченкова on 10/04/2025.
//

protocol UserAutentificationServiceProtocol {
    func fetchItems(completion: @escaping ([UserAutentificationModel]?, Error?) -> Void)
}

/// Получает данные для модуля UserAutentification
class UserAutentificationService: UserAutentificationServiceProtocol {

    func fetchItems(completion: @escaping ([UserAutentificationModel]?, Error?) -> Void) {
        completion(nil, nil)
    }
}
