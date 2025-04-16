//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

protocol MenuDataStoreProtocol {
    func fetchItems() -> [ItemModel]
    func fetchItem(by id: UniqueIdentifier) -> ItemModel?
    func saveItems(_ items: [ItemModel])
    func addItem(_ item: ItemModel)
}

/// Класс для хранения данных модуля Menu
class MenuDataStore : MenuDataStoreProtocol {
    static let shared = MenuDataStore()
    private init() {}
    
    var models: [ItemModel] = []
    
    func fetchItems() -> [ItemModel] {
        return models
    }
    
    func fetchItem(by id: UniqueIdentifier) -> ItemModel? {
        return models.first(where: { $0.uid == id })
    }
    
    func saveItems(_ items: [ItemModel]) {
        models = items
    }
    
    func addItem(_ item: ItemModel) {
        models.append(item)
    }
}
