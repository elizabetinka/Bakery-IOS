//
//  UserInfoModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 15.04.2025.
//

import Foundation


struct UserModel :  UniqueIdentifiable {
    let uid: UniqueIdentifier
    let name: String
    let points: Int
    let phoneNumber: String
}

extension UserModel: Equatable {
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.uid == rhs.uid
    }
}
