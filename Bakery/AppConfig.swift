//
//  AppConfig.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 17.04.2025.
//

struct AppConfig{
    static let phoneRegex = #"^((8|\+7)[\- ]?)(\(?\d{3}\)?[\- ]?)[\d\- ]{7}$"#
    static let userBaseUrl = "https://alfa-itmo.ru/server/v1/storage/users"
    static let itemBaseUrl = "https://alfa-itmo.ru/server/v1/storage/items"
    static let secretFilename = "userSecrets"
    static let secretType = "txt"
}
