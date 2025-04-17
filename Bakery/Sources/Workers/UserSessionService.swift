//
//  UserSessionService.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 15.04.2025.
//

import Foundation

protocol UserSessionServiceProtocol {
    func getCurrentUserId() -> UniqueIdentifier?
    func setCurrentUserId(id: UniqueIdentifier)
}

/// Получает данные для модуля Menu
class UserSessionService: UserSessionServiceProtocol {
    static let shared = UserSessionService()
    private init() {}
    
    var currentUserId : UniqueIdentifier? = nil;
    
    func getCurrentUserId() -> UniqueIdentifier? {
        currentUserId
    }
    
    func setCurrentUserId(id: UniqueIdentifier){
        currentUserId = id
    }
}
