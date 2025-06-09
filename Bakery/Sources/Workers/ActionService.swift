//
//  ActionService.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 11.05.2025.
//

import Foundation
import UIKit

protocol ActionServiceProtocol {
    func fetchActions() async -> ([ActionModel]?, ActionServiceError?)
    func fetchAction(by id: UniqueIdentifier)  async -> (ActionModel?, ActionServiceError?)
}

enum ActionServiceError: Error {
    case getActionFailed(underlyingError: Error)
    case notExists
}

/// Получает данные для модуля Common
class ActionService: ActionServiceProtocol {
    static let shared = ActionService()
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
    let imageLoader: ImageLoaderProtocol = ImageLoader.shared
    let imageDataStore: ImageDataStoreProtocol = ImageDataStore.shared
    private let baseURL = AppConfig.actionsBaseUrl
    private var username = ""
    private var password = ""
    
    func fetchActions() async -> ([ActionModel]?, ActionServiceError?){
        let (items, error) = await getActions()
        
        guard let items = items else {
            return (nil, error)
        }
        
        var ans = items.map{ActionModel(uid: $0.uid,name: $0.name, imagePath: $0.image)}
        
        ans = await setImagesToItems(items: ans)
        
        return (ans, nil)
    }
    
    
    func fetchAction(by id: UniqueIdentifier) async -> (ActionModel?, ActionServiceError?) {
        let (items, error) = await getActions()
        
        guard let items = items else {
            return (nil, error)
        }
        
        guard let item = items.first(where: { $0.uid == id }) else {
            return (nil, .notExists)
        }
        
        var ans = ActionModel(uid: item.uid, name: item.name, imagePath: item.image)
        
        ans.image = await getImage(path: ans.imagePath)
        
        return (ans, nil)
    }
    
    private func getActions() async  -> ([ActionModelJson]?, ActionServiceError?) {
        
        let loginString = "\(username):\(password)"

        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return (nil, .getActionFailed(underlyingError: URLError(.badURL)))
        }
        let base64LoginString = loginData.base64EncodedString()
    
        guard let url = URL(string: baseURL) else {
            return (nil, .getActionFailed(underlyingError: URLError(.badURL)))
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            
        do {
            let (data, _) = try await session.data(for: request)
            if let jsonString = String(data: data, encoding: .utf8) {
                //print("JSON response:\n\(jsonString)")
            } else {
                print("Не удалось декодировать data как UTF-8 строку")
            }
            let decoder = JSONDecoder()
            let ans = try decoder.decode(ActionResponse.self, from: data).actions
            return (ans, nil)
        }
        catch {
            return (nil, .getActionFailed(underlyingError: error))
        }
    }
    
    func setImagesToItems(items: [ActionModel]) async -> [ActionModel]{
        var ans = items
        for (idx, item) in ans.enumerated(){
            ans[idx].image = await getImage(path: item.imagePath)
        }
                    
        return ans
    }
    
    private func getImage(path: String) async -> UIImage? {
        if let image = imageDataStore.getImage(by: path){
            return image
        }
        let (image, _) = await imageLoader.downloadImage(path: path)
        return image
    }

}
