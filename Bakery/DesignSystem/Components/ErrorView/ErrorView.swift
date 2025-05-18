//
//  errorView.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 10.04.2025.
//

import Foundation
import UIKit


protocol ErrorViewDelegate: AnyObject {
    func reloadButtonWasTapped()
}

class ErrorView: UIView, DSView  {
    
    var title = DSLabel()
    var refreshButton = DSButton()

    let appearance: Appearance

    init(frame: CGRect = CGRect.zero, appearance: Appearance = Appearance()) {
        self.appearance = appearance
        super.init(frame: frame)
        
        addSubviews()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: DSViewModel) {
        guard let viewModel = viewModel as? ErrorViewModel else {
            fatalError("DSSpacer received wrong viewModel type")
        }
        
        self.backgroundColor = viewModel.style.backgroundColor
        self.layer.borderWidth = viewModel.style.borderWidth
        self.layer.borderColor = viewModel.style.borderColor
        self.layer.cornerRadius = viewModel.style.cornerRadius
        
        if let vm = viewModel.refreshButton{
            refreshButton.configure(with: vm)
        }
        if let vm = viewModel.title{
            title.configure(with: vm)
        }
        
        isHidden = viewModel.state == .hidden
        
        makeConfiguredConstraints(viewModel: viewModel)
    }

    func addSubviews() {
        
        addSubview(title)
        addSubview(refreshButton)
    }

    func makeConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.translatesAutoresizingMaskIntoConstraints = false

    }
    
    func makeConfiguredConstraints(viewModel: ErrorViewModel) {

        if let titleLayout = viewModel.title?.layout {
            applyLayoutToView(layout: titleLayout.margin, view: title, topView: nil, botView: refreshButton, superview: self)
        }
        
        if let buttonLayout = viewModel.refreshButton?.layout {
            applyLayoutToView(layout: buttonLayout.margin, view: refreshButton, topView: title, botView: nil, superview: self)
        }
        
    }
    
    func configure(withMessage errorMessage: String) {
    }
}

