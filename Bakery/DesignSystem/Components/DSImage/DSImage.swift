//
//  DSImage.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 06.05.2025.
//

import UIKit

final class DSImage : UIView, DSView {
    private var viewModel: DSImageViewModel?
    private var image = UIImageView()
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        addSubview(image)
    }


    func configure(with viewModel: DSViewModel) {
        guard let viewModel = viewModel as? DSImageViewModel else {
            fatalError("DSSpacer received wrong viewModel type")
        }
        self.viewModel = viewModel
        let layout = viewModel.layout.padding
        
        image.image = viewModel.image
        
//        let all = self.constraints.filter {
//            $0.firstItem === image
//        }
//        NSLayoutConstraint.deactivate(all)
        NSLayoutConstraint.deactivate(self.constraints)
        NSLayoutConstraint.deactivate(image.constraints)
        
//        self.widthAnchor.constraint(equalToConstant: viewModel.size.width+2*layout.vPadding).isActive = true
//        self.heightAnchor.constraint(equalToConstant: viewModel.size.height+2*layout.hPadding).isActive = true
//            
        
        image.widthAnchor.constraint(equalToConstant: viewModel.size.width).isActive = true
        image.heightAnchor.constraint(equalToConstant: viewModel.size.height).isActive = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: layout.vPadding).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -layout.vPadding).isActive = true
        image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: layout.hPadding ).isActive = true
        image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -layout.hPadding ).isActive = true
        
        
//        image.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        image.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: layout.hPadding).isActive = true
//        image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -layout.hPadding).isActive = true
        
        //self.layoutIfNeeded()
        invalidateIntrinsicContentSize()
        
    }
    
    override var intrinsicContentSize: CGSize {
        guard let viewModel = viewModel else {
            return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
        }

        let layout = viewModel.layout.padding
        return CGSize(
            width: image.intrinsicContentSize.width + 2 * layout.hPadding,
            height: image.intrinsicContentSize.height + 2 * layout.vPadding
        )
    }
}
    
    
