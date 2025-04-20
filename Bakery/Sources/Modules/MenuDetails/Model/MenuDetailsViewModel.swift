//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

/// Модель данных, описывающая ...
struct MenuDetailsViewModel: UniqueIdentifiable {
    let uid: UniqueIdentifier
    let name: String
    let cost: Int
    let kcal: Int
    let description: String
    let itemImage: UIImage?
}

extension MenuDetailsViewModel: Equatable {
    static func == (lhs: MenuDetailsViewModel, rhs: MenuDetailsViewModel) -> Bool {
        return lhs.uid == rhs.uid
    }
}
