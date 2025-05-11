//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

/// Модель данных, описывающая ...
struct ItemModel: UniqueIdentifiable {
    
    let uid: UniqueIdentifier
    let name: String
    let cost: Int
    let kcal: Int
    let description: String
    var itemImage: UIImage?
    var imagePath: String
    
    
    init(uid: UniqueIdentifier, name: String, cost: Int, kcal: Int, description: String, imagePath: String) {
        self.uid = uid
        self.name = name
        self.cost = cost
        self.kcal = kcal
        self.description = description
        self.imagePath = imagePath
    }
}

extension ItemModel: Equatable {
    static func == (lhs: ItemModel, rhs: ItemModel) -> Bool {
        return lhs.uid == rhs.uid
    }
}
