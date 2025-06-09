//
//  UserAutentificationViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 30.04.2025.
//

struct UserAutentificationViewModel {
    var loginButton: DSButtonViewModel?
    var phoneTextField: DSTextFieldViewModel?
    var errorModel: ErrorViewModel?
    var titleLabel: DSLabelViewModel?
    var activityIndicator: DSActivityIndicatorViewModel?
    var logoImage: DSImageViewModel?
    var spacer: DSSpacerViewModel?
    
    var content: DSContainerViewModel {
        var container = DSContainerViewModel(items: [logoImage!, titleLabel!, phoneTextField!, loginButton! ,spacer!, errorModel!, activityIndicator! ])
        container.bottomView = 4
        return container
    }
    
    var style: UserAutentivicationViewStyle = .init()
}
