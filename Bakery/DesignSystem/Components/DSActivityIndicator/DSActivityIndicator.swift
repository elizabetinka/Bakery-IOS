//
//  DSActivityIndicator.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 06.05.2025.
//

import UIKit

final class DSActivityIndicator : UIView, DSView {
    private var viewModel: DSActivityIndicatorViewModel?
    private var activityIndicator =  UIActivityIndicatorView()
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        //abel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }


    func configure(with viewModel: DSViewModel) {
        guard let viewModel = viewModel as? DSActivityIndicatorViewModel else {
            fatalError("DSSpacer received wrong viewModel type")
        }
        self.viewModel = viewModel
        
        activityIndicator.hidesWhenStopped = viewModel.style.hidesWhenStopped
        activityIndicator.style = viewModel.size.size
        activityIndicator.color = viewModel.style.color
        
        switch viewModel.state {
        case .stopped:
            activityIndicator.stopAnimating()
        case .running:
            activityIndicator.startAnimating()
        }
        
        let layout = viewModel.layout.padding
        
        activityIndicator.topAnchor.constraint(equalTo: self.topAnchor, constant: layout.vPadding).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: layout.vPadding).isActive = true
        activityIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: layout.hPadding).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: layout.hPadding).isActive = true
    }
}
