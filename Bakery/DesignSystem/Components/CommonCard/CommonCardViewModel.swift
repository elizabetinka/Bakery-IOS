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
    
    var title : DSLabelViewModel?
    var text : DSLabelViewModel?
    var activityIndicator: DSActivityIndicatorViewModel
    var backroundImageView: UIImage
    var style: CommonCardStyle
    var size: CommonCardSize? = nil
    
    var onTap: (() -> Void)?
    var layout: DSLayout
    
    
    var content: DSContainerViewModel {
        var items: [any DSViewModel] = []
        var bottomview = -1
        var topView = -1
        if let title = title {
            items.append(title)
            if (title.layout.margin.vAlign == .auto){
                bottomview  += 1
                topView = 0
            }
        }
        if let text = text {
            items.append(text)
            if (text.layout.margin.vAlign == .auto){
                bottomview  += 1
                topView = 0
            }
        }
        items.append(activityIndicator)
        var contentLayot = DSLayout(margin: DSLayoutMarging(width:.fill, topMargin: .zero, bottomMargin: .zero, HMargin: .zero), padding: .init())
        var container = DSContainerViewModel(layout: contentLayot, items: items, topView: topView, bottomView: bottomview)
        return container
    }
}
