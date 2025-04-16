//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

/// Модель данных, описывающая ...
struct CommonModel {
    //var uid: UniqueIdentifier

    struct UserInfo {
        let name: String
        let points: Int
    }
    
    let userInfo: UserInfo?
    let menuImage: UIImage
}
//
//extension CommonModel: Equatable {
//    static func == (lhs: CommonModel, rhs: CommonModel) -> Bool {
//        return lhs.uid == rhs.uid
//    }
//}
