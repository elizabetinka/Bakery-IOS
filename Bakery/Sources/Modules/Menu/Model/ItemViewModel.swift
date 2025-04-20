//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

struct ItemViewModel: UniqueIdentifiable, ViewModelProtocol {
    let uid: UniqueIdentifier
    let name: String
    let cost: Int
    let itemImage: UIImage?
}

extension ItemViewModel: Equatable {
    static func == (lhs: ItemViewModel, rhs: ItemViewModel) -> Bool {
        return lhs.uid == rhs.uid
    }
}
