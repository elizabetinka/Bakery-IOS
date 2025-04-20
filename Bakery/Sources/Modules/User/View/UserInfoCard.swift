//
//  UserInfoCard.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 18.04.2025.
//

import Foundation
import UIKit


extension UserInfoCard {
    struct LocalAppearance {
        struct MainView {
            static let backgroundColor = UIColor.systemGray6
            static let cornerRadius : CGFloat = 12
            static let shadowColor = UIColor.black.cgColor
            static let shadowOpacity : Float = 0.05
            static let shadowOffset = CGSize(width: 0, height: 2)
            static let shadowRadius : CGFloat = 4
        }
        
        struct StackView {
            static let axis = NSLayoutConstraint.Axis.horizontal
            static let spacing : CGFloat = 8
            static let alignment  = UIStackView.Alignment.center
        }
        
        struct IconView {
            static let width : CGFloat = 50
            static let height : CGFloat = 50
        }
        
        static func mainViewApplyAppereance(view: UIView){
            Appearance.mainViewApplyAppereance(view: view)
            view.backgroundColor = MainView.backgroundColor
            view.layer.cornerRadius = MainView.cornerRadius
            view.layer.shadowColor = MainView.shadowColor
            view.layer.shadowOpacity = MainView.shadowOpacity
            view.layer.shadowOffset = MainView.shadowOffset
            view.layer.shadowRadius = MainView.shadowRadius
        }
        
        static func stackApplyAppereance(view: UIStackView){
            view.axis = StackView.axis
            view.spacing = StackView.spacing
            view.alignment = StackView.alignment
        }
        
        static func imageApplyAppereance(view: UIImageView){
            view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: IconView.width),
                view.heightAnchor.constraint(equalToConstant: IconView.height),
            ])
        }
    }
}

class UserInfoCard: UIView {
    init(frame: CGRect = CGRect.zero,  icon : UIImage, titleText: String) {
        self.icon = icon
        self.titleText = titleText
        
        super.init(frame: frame)
        
        LocalAppearance.mainViewApplyAppereance(view: self)
        
        addSubviews()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(value : String){
        valueLabel.text = value
    }
    
    private let icon : UIImage
    private let titleText : String
    
    lazy private var iconView = {
        let image = UIImageView(image: icon)
        LocalAppearance.imageApplyAppereance(view: image)
        return image
    }()
    
    lazy private var titleLabel: UILabel = ViewFactory.getTitleLable(title: titleText)
    lazy private var valueLabel: UILabel = ViewFactory.getTitleLable(title: "")
    
    lazy private var headerStack : UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconView, titleLabel])
        LocalAppearance.stackApplyAppereance(view: stack)
        return stack
    }()
    
    
    private func addSubviews(){
        addSubview(headerStack)
        addSubview(valueLabel)
    }
    
    private func makeConstraints(){
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                    headerStack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
                    headerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                    headerStack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),

                    valueLabel.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 8),
                    valueLabel.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
                    valueLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
        ])
    }
    
}
