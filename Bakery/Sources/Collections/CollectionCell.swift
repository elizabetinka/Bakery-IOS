//
//  ViewModelProtocol.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 20.04.2025.
//

import Foundation
import UIKit



protocol ViewModelProtocol {
}


protocol ConfigurableView: UIView {
    associatedtype ViewModelType: ViewModelProtocol
    
    func configure(with viewModel: ViewModelType)
}


class CollectionCell<ViewType: ConfigurableView>: UICollectionViewCell {
    let customView = ViewType()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: ViewType.ViewModelType) {
        customView.configure(with: viewModel)
    }
}
