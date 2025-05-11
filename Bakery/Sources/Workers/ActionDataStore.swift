//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

protocol ActionDataStoreProtocol {
    func fetchActions() -> [ActionModel]
    func fetchAction(by id: UniqueIdentifier) -> ActionModel?
    func saveActions(_ items: [ActionModel])
    func addAction(_ item: ActionModel)
}

/// Класс для хранения данных модуля Menu
class ActionDataStore : ActionDataStoreProtocol {
    static let shared = ActionDataStore()
    private init() {}
    
    var models: [ActionModel] = []
    
    func fetchActions() -> [ActionModel] {
        return models
    }
    
    func fetchAction(by id: UniqueIdentifier) -> ActionModel? {
        return models.first(where: { $0.uid == id })
    }
    
    func saveActions(_ items: [ActionModel]) {
        models = items
    }
    
    func addAction(_ item: ActionModel) {
        models.append(item)
    }
}
