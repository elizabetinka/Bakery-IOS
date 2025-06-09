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
    
    var errorModel: ErrorViewModel?
    var activityIndicator: DSActivityIndicatorViewModel?
    
    var content: DSContainerViewModel {
        var container = DSContainerViewModel(items: [nameLabel!, phoneLabel!, stackCards! , errorModel!, activityIndicator!])
        container.bottomView = 2
        return container
    }
    
    var style: UserViewStyle = .init()
}
