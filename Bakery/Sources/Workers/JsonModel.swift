//
//  jsonModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 19.04.2025.
//

import Foundation

struct UserModelJson :  Codable{
    let uid: UniqueIdentifier
    let name: String
    let points: Int
    let phoneNumber: String
}

struct UserResponse :  Codable{
    let users: [UserModelJson]
}
struct UserRequest :  Codable{
    let users: [UserModelJson]
}

struct ItemModelJson :  Codable{
    let uid: UniqueIdentifier
    let name: String
    let cost: Int
    let kcal: Int
    let description: String
    let itemImage: String
}

struct ItemResponse :  Codable{
    let items: [ItemModelJson]
}
