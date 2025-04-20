//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

protocol MenuServiceProtocol {
    func fetchItems() async -> ([ItemModel]?, MenuServiceError?)
    func fetchItem(by id: UniqueIdentifier)  async -> (ItemModel?, MenuServiceError?)
}

enum MenuServiceError: Error {
    case getItemFailed(underlyingError: Error)
    case notExists
}

/// Получает данные для модуля Menu
class MenuService: MenuServiceProtocol {
    static let shared = MenuService()
    private init() {
        let (n,p,_) = SecretService.getCredentials()
        if let name = n, let pass = p {
            self.username = name
            self.password = pass
        }
    }
    
    private let imageLoader: ImageLoaderProtocol = ImageLoader.shared
    let session = URLSession(configuration: .default)
    private let baseURL = AppConfig.itemBaseUrl
    private var username = ""
    private var password = ""
    
    func fetchItems() async -> ([ItemModel]?, MenuServiceError?){
        var (items, error) = await getItems()
        
        guard let items = items else {
            return (nil, error)
        }
        
        var ans = items.map{ItemModel(uid: $0.uid, name: $0.name, cost: $0.cost, kcal: $0.kcal, description: $0.description)}
        
        for (idx, item) in items.enumerated() {
            let (image, _) = await imageLoader.downloadImage(path: item.itemImage)
            if let image = image {
                ans[idx].itemImage = image
            }
        }
        return (ans, nil)
    }
    
    
    func fetchItem(by id: UniqueIdentifier) async -> (ItemModel?, MenuServiceError?) {
        let (items, error) = await getItems()
        
        guard let items = items else {
            return (nil, error)
        }
        
        guard let item = items.first(where: { $0.uid == id }) else {
            return (nil, .notExists)
        }
        
        var ans = ItemModel(uid: item.uid, name: item.name, cost: item.cost, kcal: item.kcal, description: item.description)
        
        let (image, _) = await imageLoader.downloadImage(path: item.itemImage)
        if let image = image {
            ans.itemImage = image
        }
        
        return (ans, nil)
    }
    
    private func getItems() async  -> ([ItemModelJson]?, MenuServiceError?) {
        
        let loginString = "\(username):\(password)"

        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return (nil, .getItemFailed(underlyingError: URLError(.badURL)))
        }
        let base64LoginString = loginData.base64EncodedString()
    
        guard let url = URL(string: baseURL) else {
            return (nil, .getItemFailed(underlyingError: URLError(.badURL)))
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            
        do {
            let (data, _) = try await session.data(for: request)
            let decoder = JSONDecoder()
            let ans = try decoder.decode(ItemResponse.self, from: data).items
            return (ans, nil)
        }
        catch {
            return (nil, .getItemFailed(underlyingError: error))
        }
    }

}
