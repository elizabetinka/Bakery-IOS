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
    let itemImage: UIImage
}

extension ItemModel: Equatable {
    static func == (lhs: ItemModel, rhs: ItemModel) -> Bool {
        return lhs.uid == rhs.uid
    }
}
