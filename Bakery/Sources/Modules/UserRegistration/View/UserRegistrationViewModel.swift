//
//  UserRegistrationViewModel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 08.05.2025.
//

struct UserRegistrationViewModel {
    var logoImage: DSImageViewModel?
    var button: DSButtonViewModel?
    var phoneLabel: DSLabelViewModel?
    var phoneTextField: DSTextFieldViewModel?
    var nameLabel: DSLabelViewModel?
    var nameTextField: DSTextFieldViewModel?
    var errorModel: ErrorViewModel?
    var titleLabel: DSLabelViewModel?
    var activityIndicator: DSActivityIndicatorViewModel?
    
    var spacer: DSSpacerViewModel?
    
    var content: DSContainerViewModel {
        var container = DSContainerViewModel(items: [logoImage!, titleLabel!,nameLabel!, nameTextField!, phoneLabel!, phoneTextField!, button! ,spacer!, errorModel!, activityIndicator! ])
        container.bottomView = 7
        return container
    }
    
    var style: UserRegistrationViewStyle = .init()
}
