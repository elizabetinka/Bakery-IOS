//
//  UserInfoCard.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 18.04.2025.
//

import Foundation
import UIKit


struct UserInfoCardModelViewModel: DSViewModel {
    let componentType: ComponentType = .userInfoCard
    var identifier: String = "userInfoCard"
    
    var valueLabel: DSLabelViewModel?
    var headerStack: DSStackViewModel?
    
    var style: UserInfoCardStyle = .primary
    var layout: DSLayout = .init()
}
