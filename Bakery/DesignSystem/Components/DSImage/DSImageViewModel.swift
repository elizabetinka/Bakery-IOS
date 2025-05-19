//
//  DSImageViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 06.05.2025.
//

import UIKit

struct DSImageViewModel: DSViewModel {
    let componentType: ComponentType = .image
    var identifier: String = "image"
    
    var image: UIImage?
    var size: DSImageSize
    var layout: DSLayout
}

