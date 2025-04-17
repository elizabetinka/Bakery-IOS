//
//  AuthChekerWorker.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 10.04.2025.
//

import Foundation


enum MenuWorkerError: Error {
    case getInfoFailed(underlyingError: Error)
}


struct WorkerItemInfo {
    let id: Int
    let name: String
    let cost: Int
    let kcal: Int
    let description: String
}

class ItemWorker {

    
    static let shared = ItemWorker()
    
    private init() {}
    
    func getInfo(completion: @escaping (WorkerItemInfo?, MenuWorkerError?) -> Void) {
        completion(WorkerItemInfo(id: 0, name: "Елизавета Кравченкова", cost: 1000, kcal: 0, description: "cake"), nil)
    }
    
    func getItemById(_ id: Int, completion: @escaping (WorkerItemInfo?, MenuWorkerError?) -> Void) {
        completion(WorkerItemInfo(id: 0, name: "Елизавета Кравченкова", cost: 1000, kcal: 0, description: "cake"), nil)
    }
}
