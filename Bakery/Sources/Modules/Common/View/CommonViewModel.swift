//
//  CommonViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 11.05.2025.
//

struct CommonViewModel {
    
    var card0: CommonCardViewModel
    var promotionViewModel: DSLabelViewModel
    var card1: CommonCardViewModel
    var promotionViewModel2: DSLabelViewModel
    var card2: CommonCardViewModel
    
    var content: DSContainerViewModel {
        let content = DSContainerViewModel(identifier: "commonView", items: [card0, promotionViewModel, card1, promotionViewModel2, card2], topView: 0, bottomView: 4)
        return content
    }
    
    var style: CommonViewStyle = .init()
}
