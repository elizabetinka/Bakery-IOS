//
//  MenuCell.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 10.04.2025.
//

import Foundation
import UIKit


extension MenuCell {
    struct Appearance {
        let labelFontSize: CGFloat = 24
        let imageViewTintColor: UIColor = .init(red: 247/255, green: 205/255, blue: 70/255, alpha: 1)
        let landmarkImageEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 0)
        let labelLeftOffset: CGFloat = 8
        let favoriteIconHeight: CGFloat = 30
        let favoriteIconRightOffset: CGFloat = -8
        let labelFont = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
}

class MenuCell: UITableViewCell {
    
    // MARK: - Public Properties
    static let reuseIdentifier = "menuCell"
    
    var appearance: Appearance = Appearance()
    
    // MARK: - Private Properties
    
    private lazy var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        
        return imageView
    }()

    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        setupViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with cellPresentable: CommonItemViewModel?) {
        if let unwrapped = cellPresentable {
            myImageView.image = unwrapped.menuImage
        }
        else{
            myImageView.image = UIImage()
        }
    }

    
    // MARK: - Private Methods
    private func setupViews() {
        contentView.addSubview(myImageView)
    }

    private func addConstraints() {

    }
    
}

