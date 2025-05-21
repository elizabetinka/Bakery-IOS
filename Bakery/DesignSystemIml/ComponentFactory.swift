//
//  ComponentFactory.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 08.05.2025.
//

import UIKit

protocol BdUIMapper {
    static func makeView(from viewModel: DSViewModel) -> DSView
}


struct ComponentFactory: BdUIMapper {
    static func makeView(from viewModel: DSViewModel) -> DSView {
        switch viewModel.componentType {
            case .button:
                guard let buttonVM = viewModel as? DSButtonViewModel else {
                    fatalError("Invalid ViewModel for button")
                }
                let button = DSButton()
                button.configure(with: buttonVM)
                button.accessibilityIdentifier = buttonVM.identifier
                return button
                
            case .text:
                guard let textVM = viewModel as? DSTextFieldViewModel else {
                    fatalError("Invalid ViewModel for text")
                }
                let textField = DSTextField()
                textField.configure(with: textVM)
                textField.accessibilityIdentifier = textVM.identifier
                return textField
            
            case .label:
                guard let labelVM = viewModel as? DSLabelViewModel else {
                    fatalError("Invalid ViewModel for text")
                }
                let label = DSLabel()
                label.configure(with: labelVM)
                label.accessibilityIdentifier = labelVM.identifier
                return label
            
            case .image:
                guard let vm = viewModel as? DSImageViewModel else {
                    fatalError("Invalid ViewModel for text")
                }
                let view = DSImage()
                view.configure(with: vm)
                view.accessibilityIdentifier = vm.identifier
                return view
            
            case .activityIndicator:
                guard let vm = viewModel as? DSActivityIndicatorViewModel else {
                    fatalError("Invalid ViewModel for text")
                }
                let view = DSActivityIndicator()
                view.configure(with: vm)
                view.accessibilityIdentifier = vm.identifier
                return view
            
            case .errorView:
                guard let vm = viewModel as? ErrorViewModel else {
                    fatalError("Invalid ViewModel for text")
                }
                let view = ErrorView()
                view.configure(with: vm)
                view.accessibilityIdentifier = vm.identifier
                return view
                    
            case .stack:
                guard let vm = viewModel as? DSStackViewModel else {
                    fatalError("Invalid ViewModel for text")
                }
                let view = DSStack(viewModel:vm)
                view.configure(with: vm)
                view.accessibilityIdentifier = vm.identifier
                return view
            
            case .container:
                guard let vm = viewModel as? DSContainerViewModel else {
                    fatalError("Invalid ViewModel for text")
                }
                let view = DSContainer(viewModel:vm)
                view.configure(with: vm)
                view.accessibilityIdentifier = vm.identifier
                return view
            
            case .spacer:
                guard let vm = viewModel as? DSSpacerViewModel else {
                    fatalError("Invalid ViewModel for text")
                }
                let view = DSSpacer()
                view.configure(with: vm)
                view.accessibilityIdentifier = vm.identifier
                return view
            case .userInfoCard:
                guard let vm = viewModel as? UserInfoCardModelViewModel else {
                    fatalError("Invalid ViewModel for text")
                }
                let view = UserInfoCard(viewModel:vm)
                view.configure(with: vm)
                view.accessibilityIdentifier = vm.identifier
                return view
            case .commonCard:
                guard let vm = viewModel as? CommonCardViewModel else {
                    fatalError("Invalid ViewModel for text")
                }
                let view = CommonCard(vm: vm)
                view.configure(with: vm)
                view.accessibilityIdentifier = vm.identifier
                return view
            default:
                fatalError("Unsupported component type")
            }
    }
    
    static func makeView(from models: [DSViewModel]) -> DSView {
        let containerLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin:.zero,bottomMargin: .zero, HMargin: .zero), padding: .init())
        let vm = DSContainerViewModel(layout: containerLayout, items: models, topView: 0, bottomView: models.count-1)
        return makeView(from: vm)
    }
        
}
