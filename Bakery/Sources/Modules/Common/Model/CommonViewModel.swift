//
//  CommonViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 10.04.2025.
//

import Foundation
import UIKit


struct CommonUserViewModel {
    let name: String
    let points: Int
}

struct CommonItemViewModel {
    let menuImage: UIImage
}

struct CommonViewModel {
    var user : CommonUserViewModel?
    var item: CommonItemViewModel?
}
