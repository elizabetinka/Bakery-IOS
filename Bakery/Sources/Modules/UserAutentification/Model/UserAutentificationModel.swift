//
//  Created by Елизавета Кравченкова on 10/04/2025.
//

/// Модель данных, описывающая ...
struct UserAutentificationModel: UniqueIdentifiable {
    // Example
    let uid: UniqueIdentifier
    let name: String
}

extension UserAutentificationModel: Equatable {
    static func == (lhs: UserAutentificationModel, rhs: UserAutentificationModel) -> Bool {
        return lhs.uid == rhs.uid
    }
}
