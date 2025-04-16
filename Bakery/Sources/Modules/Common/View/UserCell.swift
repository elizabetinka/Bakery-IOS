//
//  UserCell.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 10.04.2025.
//

import Foundation
import UIKit


extension UserCell {
    struct Appearance {
        let labelFontSize: CGFloat = 24
        let imageViewTintColor: UIColor = .init(red: 247/255, green: 205/255, blue: 70/255, alpha: 1)
        let landmarkImageEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 0)
        let labelLeftOffset: CGFloat = 8
        let favoriteIconHeight: CGFloat = 30
        let favoriteIconRightOffset: CGFloat = -8
    }
}

class UserCell: UITableViewCell {
    
    // MARK: - Public Properties
    static let reuseIdentifier = "userCell"
    
    var appearance: Appearance = Appearance()
    
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: appearance.labelFontSize)
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: appearance.labelFontSize)
        label.numberOfLines = 1
        
        return label
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
    func configure(with cellPresentable: CommonViewModel) {
        if let unwrapped = cellPresentable.userInfo {
            nameLabel.text = unwrapped.name
            pointsLabel.text = String(unwrapped.points)
        }
        else{
            nameLabel.text = "Регистрация"
            pointsLabel.text = ""
        }
    }

    
    // MARK: - Private Methods
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(pointsLabel)
    }

    private func addConstraints() {

    }
    
}
