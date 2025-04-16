//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

/// Модель данных, описывающая ...
struct UserModel {
    // Example
    // let uid: UniqueIdentifier
    
    struct UserInfo{
        let name: String
        let points: Int
        let phoneNumber: String
    }
    
    enum UserStatus{
        case isEntered(UserInfo)
        case needAuth
    }
    
    let userStatus : UserStatus
}

//extension UserModel: Equatable {
//    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
//        return lhs.uid == rhs.uid
//    }
//}
