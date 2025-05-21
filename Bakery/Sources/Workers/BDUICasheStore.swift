//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import Foundation

protocol BDUICasheStoreProtocol {
    func getData(endpoint: String, key: String) -> Data?
    func saveData(endpoint: String, key: String, data: Data)
}


/// Класс для хранения данных модуля Universal
class BDUICasheStore : BDUICasheStoreProtocol {
    
    var dict: [String: Data] = [:]
    
    static let shared = BDUICasheStore()
    private init() {}
    
    func getData(endpoint: String, key: String) -> Data? {
        dict["\(endpoint)\(key)"]
    }
    
    func saveData(endpoint: String, key: String, data: Data) {
        dict["\(endpoint)\(key)"] = data
    }
}
