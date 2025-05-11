//
//  DSLabel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 03.05.2025.
//

import UIKit

final class DSLabel : UIView, DSView {
    private var viewModel: DSLabelViewModel?
    private var label = UILabel()
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        addSubview(label)
        self.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
    }


    func configure(with viewModel: DSViewModel) {
        guard let viewModel = viewModel as? DSLabelViewModel else {
            fatalError("DSSpacer received wrong viewModel type")
        }
        self.viewModel = viewModel
        
        label.text = viewModel.text
        
        label.textColor = viewModel.style.textColor()
        label.numberOfLines = viewModel.style.numberOfLines
        label.lineBreakMode = viewModel.style.lineBreakMode
        label.adjustsFontSizeToFitWidth = viewModel.style.adjustsFontSizeToFitWidth
        label.textAlignment = viewModel.style.textAlignment(for: viewModel.style)
        
        label.font = viewModel.size.font(for: viewModel.style)

        label.isHidden = viewModel.state == .hidden
        
        makeConfiguredConstraints(viewModel: viewModel)
    }
    
    func makeConfiguredConstraints(viewModel: DSLabelViewModel){
        
        let layout = viewModel.layout.padding
        
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: layout.vPadding).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: layout.vPadding).isActive = true
        
        
        label.textAlignment = viewModel.style.textAlignment(for: viewModel.style)
        
        switch label.textAlignment {
        case .left:
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: layout.hPadding).isActive = true
            label.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -layout.hPadding).isActive = true
        case .right:
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -layout.hPadding).isActive = true
            label.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: layout.hPadding).isActive = true
        default:
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: layout.hPadding).isActive = true
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -layout.hPadding).isActive = true
        }
    }
    
}
