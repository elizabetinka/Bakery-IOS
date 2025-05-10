//
//  UserViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 08.05.2025.
//

struct UserViewModel {
    var nameLabel: DSLabelViewModel?
    var phoneLabel: DSLabelViewModel?
    var stackCards: DSStackViewModel?
//    var bonusCard: UserInfoCardModelViewModel?
//    var statusCard: UserInfoCardModelViewModel?
    
    var errorModel: ErrorViewModel?
    var activityIndicator: DSActivityIndicatorViewModel?
    
    var content: DSContainerViewModel {
        var container = DSContainerViewModel(items: [nameLabel!, phoneLabel!, stackCards! ])
        container.bottomView = 2
        return container
    }
    
    var style: UserViewStyle = .init()
}
