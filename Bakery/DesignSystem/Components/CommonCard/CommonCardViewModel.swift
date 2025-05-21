//
//  CommonCard.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 10.05.2025.
//

import UIKit

struct CommonCardViewModel: DSViewModel {
    let componentType: ComponentType = .commonCard
    var identifier: String = "commonScreenCard"
    
    var backroundImageView: UIImage?
    var style: CommonCardStyle
    var size: CommonCardSize? = nil
    
    var onTap: (() -> Void)?
    var layout: DSLayout
    var content: DSContainerViewModel
}
