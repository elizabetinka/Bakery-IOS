//
//  CommonViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 10.04.2025.
//

import Foundation
import UIKit


struct CommonViewModel {
    //var uid: UniqueIdentifier

    struct UserInfo {
        let name: String
        let points: Int
    }
    
    let userInfo: UserInfo?
    let menuImage: UIImage
}
