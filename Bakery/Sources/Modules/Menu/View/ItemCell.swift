//
//  ItemCell.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 15.04.2025.
//

import UIKit

extension ItemCell {
    struct Appearance {
        let backgroundColor = UIColor.white
        let cornerRadius: CGFloat = 16
        let clipsToBounds = true
    }
}

class ItemCell: UICollectionViewCell {
    static let reuseId = "ItemCell"
    let appearance: Appearance = Appearance()

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: ItemViewModel) {
        imageView.image = item.itemImage
        titleLabel.text = item.name
        priceLabel.text = "\(item.cost) ₽"
    }

    private func setupUI() {
        contentView.backgroundColor = appearance.backgroundColor
        contentView.layer.cornerRadius = appearance.cornerRadius
        contentView.clipsToBounds = appearance.clipsToBounds

        
    }
}
