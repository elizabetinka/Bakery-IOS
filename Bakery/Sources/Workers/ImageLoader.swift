//
//  ImageLoader.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 20.04.2025.
//

import Foundation
import UIKit


protocol ImageLoaderProtocol {
    func downloadImage(path: String) async -> (UIImage?, Error?)
}

class ImageLoader: ImageLoaderProtocol {
    static let shared = ImageLoader()
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = AppConfig.timeoutIntervalForRequest
        config.timeoutIntervalForResource = AppConfig.timeoutIntervalForResource
        session = URLSession(configuration: config)
    }
    
    let session : URLSession
    
    func downloadImage(path: String) async -> (UIImage?, Error?){
        guard let url = URL(string: path) else {
            return (nil, URLError(.badURL))
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpRes = response as? HTTPURLResponse,
                200..<300 ~= httpRes.statusCode else {
                return (nil, URLError(.badServerResponse))
            }
            
            let downloadedImage = UIImage(data: data)
            return (downloadedImage, nil)
        }
        catch {
            return (nil, error)
        }
    }
}
