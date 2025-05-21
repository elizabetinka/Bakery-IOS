//
//  UserService.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 15.04.2025.
//

import Foundation

protocol BDUIServiceProtocol {
    func getData(endpoint: String, key: String) async -> (Data?, BDUIServiceError?)
}

enum BDUIServiceError: Error {
    case getDataFailed(underlyingError: Error)
}

extension BDUIServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .getDataFailed(underlyingError):
            return NSLocalizedString(underlyingError.localizedDescription, comment: "")
        }
    }
}

/// Получает данные для модуля Universal
    class BDUIService: BDUIServiceProtocol {
    static let shared = BDUIService()
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
    private var username = ""
    private var password = ""

    
    func getData(endpoint: String, key: String) async -> (Data?, BDUIServiceError?) {
        let loginString = "\(username):\(password)"

        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return (nil, .getDataFailed(underlyingError: URLError(.badURL)))
        }
        let base64LoginString = loginData.base64EncodedString()
        
        let baseURL = "\(endpoint)\(key)"
        guard let url = URL(string: baseURL) else {
            return (nil, .getDataFailed(underlyingError: URLError(.badURL)))
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            
        do {
            let (data, _) = try await session.data(for: request)
            return (data, nil)
        }
        catch {
            return (nil, .getDataFailed(underlyingError: error))
        }
    }
}
