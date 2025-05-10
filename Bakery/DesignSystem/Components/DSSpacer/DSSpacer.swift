//
//  DSSpacer.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 09.05.2025.
//

import UIKit

final class DSSpacer : UIView, DSView {
    private var viewModel: DSSpacerViewModel?
    private var emptyView = UIView()
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        addSubview(emptyView)
        self.translatesAutoresizingMaskIntoConstraints = false
        emptyView.translatesAutoresizingMaskIntoConstraints = false
    }


    func configure(with viewModel: DSViewModel) {
        guard let spacerViewModel = viewModel as? DSSpacerViewModel else {
            fatalError("DSSpacer received wrong viewModel type")
        }
        self.viewModel = spacerViewModel
        
        let padding = viewModel.layout.padding
        
        emptyView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding.vPadding).isActive = true
        emptyView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: padding.vPadding).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: padding.hPadding).isActive = true
        emptyView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding.hPadding).isActive = true
        
        emptyView.heightAnchor.constraint(greaterThanOrEqualToConstant: spacerViewModel.minHeight).isActive = true
    }
    
}
