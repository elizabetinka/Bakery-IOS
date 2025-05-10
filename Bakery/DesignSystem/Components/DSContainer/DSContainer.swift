//
//  DSContainer 2.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 09.05.2025.
//

import UIKit


final class DSContainer : UIView, DSView {
    private var viewModel: DSContainerViewModel?
    private var container = UIView()
    private var items: [DSView] = []
    
    
    public init(viewModel: DSContainerViewModel, frame: CGRect = .zero) {
        super.init(frame: frame)
        commonInit()
        
        setup(with: viewModel)
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        addSubview(container)
        self.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
    }


    func setup(with viewModel: DSContainerViewModel) {
        print("setuo container")
        self.viewModel = viewModel
        updateSubviews(with: viewModel)
    }
    
    func configure(with viewModel: DSViewModel) {
        guard let vm = viewModel as? DSContainerViewModel else {
            fatalError("DSSpacer received wrong viewModel type")
        }
        self.viewModel = vm
        
        for (i, item) in items.enumerated() {
            if let m = vm.items[safe: i]{
                item.configure(with: m)
            }
        }
        
        let padding = vm.layout.padding
        
        NSLayoutConstraint.deactivate(self.constraints)
        NSLayoutConstraint.deactivate(container.constraints)
        
        container.topAnchor.constraint(equalTo: self.topAnchor, constant: padding.vPadding).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding.vPadding).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding.hPadding).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding.hPadding).isActive = true
        
        makeConfiguredConstraints()
    }
    
    private func updateSubviews(with viewModel: DSContainerViewModel) {
        items.removeAll()
        container.subviews.forEach { $0.removeFromSuperview() }
        
        viewModel.items.forEach {
            let view = ComponentFactory.makeView(from: $0)
            items.append(view)
            container.addSubview(view)
        }
    }
    
    func makeConfiguredConstraints() {
        
        for item in items {
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        for (i, item) in items.enumerated() {
    
            let layout = viewModel!.items[i].layout
            if i ==  viewModel?.topView {
                applyLayoutToView(layout: layout.margin, view: item, topView: nil, botView: items[safe: i+1], superview: container)
            }
            else if i == viewModel?.bottomView {
                applyLayoutToView(layout: layout.margin, view: item, topView: items[i-1], botView: nil, superview: container)
            }
            else {
                applyLayoutToView(layout: layout.margin, view: item, topView: items[i-1], botView: items[safe: i+1], superview: container)
            }
        }
      
    }
    
}
