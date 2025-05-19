//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

/// Модель данных, описывающая ...
struct ActionModel: UniqueIdentifiable {
    
    let uid: UniqueIdentifier
    let name: String
    var image: UIImage?
    var imagePath: String
    
    
    init(uid: UniqueIdentifier, name:String, imagePath: String) {
        self.uid = uid
        self.name = name
        self.imagePath = imagePath
    }
}

extension ActionModel: Equatable {
    static func == (lhs: ActionModel, rhs: ActionModel) -> Bool {
        return lhs.uid == rhs.uid
    }
}
