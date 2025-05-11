//
//  DSStack.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 08.05.2025.
//

import UIKit

final class DSStack : UIView, DSView {
    private var viewModel: DSStackViewModel?
    private var stack = UIStackView()
    private var items: [DSView] = []
    
    
    public init(viewModel: DSStackViewModel, frame: CGRect = .zero) {
        super.init(frame: frame)
        commonInit()
        
        setup(with: viewModel)
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        addSubview(stack)
        self.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        stack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        stack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        //label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }

    
    func setup(with viewModel: DSStackViewModel) {
        self.viewModel = viewModel
        items.removeAll()
        stack.subviews.forEach { $0.removeFromSuperview() }
        
        viewModel.items.forEach {
            let view = ComponentFactory.makeView(from: $0)
            //print("in stack view.frame \(view.frame)")
            items.append(view)
            stack.addArrangedSubview(view)
        }
    }
    func configure(with viewModel: DSViewModel) {
        guard let viewModel = viewModel as? DSStackViewModel else {
            fatalError("DSSpacer received wrong viewModel type")
        }
        self.viewModel = viewModel
        
        stack.axis = viewModel.style.axis
        stack.spacing = viewModel.size.spacing(for: viewModel.style)
        stack.alignment = viewModel.alignment.alignment()
        stack.distribution = viewModel.alignment.distribution
        
        
        NSLayoutConstraint.deactivate(self.constraints)
        //NSLayoutConstraint.deactivate(stack.constraints)
        
        
        for (i, item) in items.enumerated() {
            if let m = viewModel.items[safe: i]{
                item.configure(with: m)
                item.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        
        
        let padding = viewModel.layout.padding
        
        stack.topAnchor.constraint(equalTo: self.topAnchor, constant: padding.vPadding).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding.vPadding).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding.hPadding).isActive = true
        stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding.hPadding).isActive = true
        
        //stack.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        //layoutIfNeeded()
        //print("stack \(stack.frame)")
        //print("stack self \(self.frame)")
    }
}
