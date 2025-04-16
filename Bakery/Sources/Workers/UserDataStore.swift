//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

protocol UserDataStoreProtocol {
    func fetchUsers() -> [UserModel]
    func fetchUser(by id: UniqueIdentifier) -> UserModel?
    func saveUsers(_ users: [UserModel])
    func addUser(_ user: UserModel)
}


/// Класс для хранения данных модуля User
class UserDataStore : UserDataStoreProtocol {
    var models: [UserModel] = []
    
    static let shared = UserDataStore()
    private init() {}
    
    func fetchUsers() -> [UserModel] {
        return models
    }
    
    func fetchUser(by id: UniqueIdentifier) -> UserModel? {
        return models.first(where: { $0.uid == id })
    }
    
    func saveUsers(_ items: [UserModel]) {
        models = items
    }
    
    func addUser(_ item: UserModel) {
        models.append(item)
    }
}
