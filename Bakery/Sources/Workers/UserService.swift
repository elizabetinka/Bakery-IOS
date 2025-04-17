//
//  UserService.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 15.04.2025.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUsers(completion: @escaping ([UserModel]?, UserServiceError?) -> Void)
    func fetchUser(by id: UniqueIdentifier, completion: @escaping (UserModel?, UserServiceError?) -> Void)
    func addUser(user: UserModel, completion: @escaping (UserModel?, UserServiceError?) -> Void)
}

enum UserServiceError: Error {
    case getUserFailed(underlyingError: Error)
    case notExists
    case alreadyExists
}

extension UserServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .getUserFailed(underlyingError):
            return NSLocalizedString(underlyingError.localizedDescription, comment: "")
        case .notExists:
            return NSLocalizedString("Такого пользователя нет", comment: "")
        case .alreadyExists:
            return NSLocalizedString("Пользователь с таким номером уже существует", comment: "")
        }
    }
}
/// Получает данные для модуля Menu
class UserService: UserServiceProtocol {
    static let shared = UserService()
    private init() {}
    
    private var lastId : UniqueIdentifier = 1;
    private var users: [UserModel] = [UserModel(uid: 1, name: "Елизавета Кравченкова", points: 1000, phoneNumner: "1233444567")]
    
    func fetchUsers(completion: @escaping ([UserModel]?, UserServiceError?) -> Void) {
        completion(users, nil)
    }
    func fetchUser(by id: UniqueIdentifier, completion: @escaping (UserModel?, UserServiceError?) -> Void) {
        if let user = users.first(where: { $0.uid == id }) {
            completion(user, nil)
            return
        }

        completion(nil, .notExists)
    }
    
    func addUser(user: UserModel, completion: @escaping (UserModel?, UserServiceError?) -> Void) {
        if users.first(where: { $0.phoneNumner == user.phoneNumner }) != nil {
            completion(nil, .alreadyExists)
            return
        }
        lastId += 1
        let model = UserModel(uid: lastId, name: user.name, points: user.points, phoneNumner: user.phoneNumner)
        users.append(model)
        completion(model, nil)
    }
}
