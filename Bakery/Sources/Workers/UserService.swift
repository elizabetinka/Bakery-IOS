//
//  UserService.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 15.04.2025.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUsers() async -> ([UserModel]?, UserServiceError?)
    func fetchUser(by id: UniqueIdentifier) async -> (UserModel?, UserServiceError?)
    func addUser(user: UserModel) async -> (UserModel?, UserServiceError?)
}

enum UserServiceError: Error {
    case getUserFailed(underlyingError: Error)
    case notExists
    case alreadyExists
    case unknowm
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
        case .unknowm:
            return NSLocalizedString("Неизвестная ошибка. Проблемы с сервером", comment: "")
        }
    }
}
/// Получает данные для модуля Menu
class UserService: UserServiceProtocol {
    static let shared = UserService()
    private init() {
        let (n,p,_) = SecretService.getCredentials()
        if let name = n, let pass = p {
            self.username = name
            self.password = pass
        }
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = AppConfig.timeoutIntervalForRequest
        config.timeoutIntervalForResource = AppConfig.timeoutIntervalForResource
        session = URLSession(configuration: config)
    }
    
    let session : URLSession
    private let baseURL = AppConfig.userBaseUrl
    private var username = ""
    private var password = ""
    
    private var lastId : UniqueIdentifier? = nil;
    
    func fetchUsers() async -> ([UserModel]?, UserServiceError?) {
        let (users, error) = await getUsers()
        
        if let error = error {
            return (nil, error)
        } else if let models = users {
            let ans = models.map{UserModel(uid: $0.uid, name: $0.name, points: $0.points, phoneNumber: $0.phoneNumber)}
            return (ans, nil)
        }
        else{
            return (nil, .unknowm)
        }
    }
    func fetchUser(by id: UniqueIdentifier)  async  -> (UserModel?, UserServiceError?){
        let (users, error) = await getUsers()
        
        if let error = error {
            return (nil, error)
        } else if let models = users {
            if let user = models.first(where: { $0.uid == id }) {
                let ans = UserModel(uid: user.uid, name: user.name, points: user.points, phoneNumber: user.phoneNumber)
                return (ans, nil)
            }
            return (nil, .notExists)
        }
        else{
            return (nil, .unknowm)
        }
    }
    
    func addUser(user: UserModel) async -> (UserModel?, UserServiceError?){
        
        let (users, error) = await getUsers()
        print(users)
        
        guard error == nil else {
            return (nil, error)
        }
        
        guard var users = users else {
            return (nil, .unknowm)
        }
        
        let exists = users.contains { u in
            u.phoneNumber == user.phoneNumber
        }
        
        guard !exists else {
            return (nil, .alreadyExists)
        }
        
        if lastId == nil {
            lastId = users.max(by: { $0.uid < $1.uid })?.uid ?? 0
        }
        lastId! += 1
        
        let jsonModel = UserModelJson(uid: lastId!, name: user.name, points: user.points, phoneNumber: user.phoneNumber)
        users.append(jsonModel)
        
        let err = await postUsers(users: users)
        
        guard err == nil else {
            return (nil, err)
        }
        
        let ans = UserModel(uid: jsonModel.uid, name: jsonModel.name, points: jsonModel.points, phoneNumber: jsonModel.phoneNumber)
        return (ans, nil)
    }
    
    private func getUsers() async  -> ([UserModelJson]?, UserServiceError?) {
        let loginString = "\(username):\(password)"

        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return (nil, .getUserFailed(underlyingError: URLError(.badURL)))
        }
        let base64LoginString = loginData.base64EncodedString()
    
        guard let url = URL(string: baseURL) else {
            return (nil, .getUserFailed(underlyingError: URLError(.badURL)))
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            
        do {
            let (data, _) = try await session.data(for: request)
            let decoder = JSONDecoder()
            let ans = try decoder.decode(UserResponse.self, from: data).users
            return (ans, nil)
        }
        catch {
            return (nil, .getUserFailed(underlyingError: error))
        }
    }
    
    private func postUsers(users: [UserModelJson]) async -> UserServiceError?  {
        
        let loginString = "\(username):\(password)"

        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return .getUserFailed(underlyingError: URLError(.badURL))
        }
        let base64LoginString = loginData.base64EncodedString()
    
        guard let url = URL(string: baseURL) else {
            return .getUserFailed(underlyingError: URLError(.badURL))
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload = UserRequest(users: users)
        
        do{
            let jsonData = try JSONEncoder().encode(payload)
            request.httpBody = jsonData
            let (_, response) = try await session.data(for: request)
            
            guard let httpRes = response as? HTTPURLResponse,
                  200..<300 ~= httpRes.statusCode else {
                throw URLError(.badServerResponse)
            }
        }
        catch {
            return .getUserFailed(underlyingError: error)
        }
        return nil
    }
}
