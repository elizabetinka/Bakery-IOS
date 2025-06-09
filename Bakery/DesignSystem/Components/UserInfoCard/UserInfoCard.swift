//
//  UserInfoCard.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 18.04.2025.
//

import Foundation
import UIKit

class UserInfoCard: UIView, DSView {
    private var viewModel: UserInfoCardModelViewModel
    
    init(viewModel: UserInfoCardModelViewModel, frame: CGRect = CGRect.zero) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setup(with: viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var valueLabel: DSView?
    private var headerStack: DSView?
    
    func setup(with viewModel: UserInfoCardModelViewModel) {
        self.viewModel = viewModel
        self.subviews.forEach { $0.removeFromSuperview() }
        
        if let vm = viewModel.headerStack {
            headerStack = ComponentFactory.makeView(from: vm)
            self.addSubview(headerStack!)
        }
        if let vm = viewModel.valueLabel {
            valueLabel = ComponentFactory.makeView(from: vm)
            self.addSubview(valueLabel!)
        }
    }
    
    func configure(with viewModel: DSViewModel) {
        guard let viewModel = viewModel as? UserInfoCardModelViewModel else {
            fatalError("DSSpacer received wrong viewModel type")
        }
        
        self.backgroundColor = viewModel.style.backgroundColor
        self.layer.cornerRadius = viewModel.style.cornerRadius
        self.layer.shadowColor = viewModel.style.shadowColor
        self.layer.shadowOpacity = viewModel.style.shadowOpacity
        self.layer.shadowOffset = viewModel.style.shadowOffset
        self.layer.shadowRadius = viewModel.style.shadowRadius
        

        if let vm = viewModel.headerStack {
            headerStack?.configure(with: vm)
        }
        if let vm = viewModel.valueLabel{
            valueLabel?.configure(with: vm)
        }

        makeConfiguredConstraints(viewModel: viewModel)
    }

    func makeConfiguredConstraints(viewModel: UserInfoCardModelViewModel) {
        
        headerStack?.translatesAutoresizingMaskIntoConstraints = false
        valueLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        if let headerLayout = viewModel.headerStack?.layout, let view = headerStack {
            LayoutUtils.applyLayoutToView(layout: headerLayout.margin, view: view, topView: nil, botView: valueLabel, superview: self)
        }
        
        if let valueLayout = viewModel.valueLabel?.layout, let view = valueLabel {
            LayoutUtils.applyLayoutToView(layout: valueLayout.margin, view: view, topView: headerStack, botView: nil, superview: self)
        }
    }
}
