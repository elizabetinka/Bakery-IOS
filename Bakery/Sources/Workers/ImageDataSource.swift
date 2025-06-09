//
//  ImageDataSource.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 20.04.2025.
//

import Foundation
import UIKit


protocol ImageDataStoreProtocol {
    func getImage(by path: String) -> UIImage?
    func saveImage(path: String, image: UIImage)
}


/// Класс для хранения данных модуля User
class ImageDataStore : ImageDataStoreProtocol {
    var images: [String:UIImage] = [:]
    
    static let shared = ImageDataStore()
    private init() {}
    
    func getImage(by path: String) -> UIImage? {
        images[path]
    }
    
    func saveImage(path: String, image: UIImage) {
        images[path] = image
    }
}
