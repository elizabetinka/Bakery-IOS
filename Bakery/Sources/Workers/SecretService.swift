//
//  SecretService.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 20.04.2025.
//

import Foundation

enum SecretServiceError: Error {
    case authFailed(message: String)
}

class SecretService {    
    private static let filename = AppConfig.secretFilename
    private static let fileType = AppConfig.secretType
    
    static func getCredentials() -> (String?, String?,Error?) {
        if let path = Bundle.main.path(forResource: filename, ofType: fileType) {
            
            do {
                let content = try String(contentsOfFile: path, encoding: .utf8)
                let words = content.split(separator: " ")
                guard words.count >= 2 else {
                    return (nil,nil,SecretServiceError.authFailed(message: "не удалось распознать формат файла секретов"))
                }

                return (String(words[0]), String(words[1]), nil)
                
            } catch {
                return (nil,nil,SecretServiceError.authFailed(message: "не удалось прочитать файл с секретами"))
            }
        }
        return (nil,nil,SecretServiceError.authFailed(message: "нет файла с секретами"))
    }
}
