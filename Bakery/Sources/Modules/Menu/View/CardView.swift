//
//  CardView.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 20.04.2025.
//

import Foundation
import UIKit

extension CardView {
    struct LocalAppearance {
        struct MainView {
            static let cornerRadius : CGFloat = 12
            static let shadowColor = UIColor.black.cgColor
            static let shadowOpacity : Float = 0.1
            static let shadowOffset = CGSize(width: 0, height: 2)
            static let shadowRadius : CGFloat = 4
        }
        
        static func mainViewApplyAppereance(view: UIView){
            Appearance.mainViewApplyAppereance(view: view)
            view.layer.cornerRadius = MainView.cornerRadius
            view.layer.shadowColor = MainView.shadowColor
            view.layer.shadowOpacity = MainView.shadowOpacity
            view.layer.shadowOffset = MainView.shadowOffset
            view.layer.shadowRadius = MainView.shadowRadius
        }
        
        struct ImageView {
            static let contentMode = UIView.ContentMode.scaleAspectFill
            static let clipsToBounds = true
            static let cornerRadius : CGFloat = 12
        }
        
        static func imageViewApplyAppereance(view: UIImageView){
            Appearance.mainViewApplyAppereance(view: view)
            view.contentMode = ImageView.contentMode
            view.clipsToBounds = ImageView.clipsToBounds
            view.layer.cornerRadius = ImageView.cornerRadius
        }
        
        struct TitleLabel {
            
            enum TitleFont {
                case Level1
                case Level2
            }
            
            static let  textColor =  UIColor.black
            static let  fontLevel1 = UIFont.boldSystemFont(ofSize: 16)
            static let  fontLevel2 = UIFont.systemFont(ofSize: 14)
            static let  numberOfLines = 0
            static let  lineBreakMode = NSLineBreakMode.byWordWrapping
            static let  adjustsFontSizeToFitWidth = false
            
        }
        
        static func labelViewApplyAppereance(textLabel: UILabel, level : TitleLabel.TitleFont  = .Level2) {
            textLabel.textColor = TitleLabel.textColor
            switch level {
            case .Level1:
                textLabel.font = TitleLabel.fontLevel1
            case .Level2:
                textLabel.font = TitleLabel.fontLevel2
            }
            textLabel.numberOfLines = TitleLabel.numberOfLines
            textLabel.lineBreakMode = TitleLabel.lineBreakMode
            textLabel.adjustsFontSizeToFitWidth = TitleLabel.adjustsFontSizeToFitWidth
        }
    }
}


class CardView : UIView, ConfigurableView {
    typealias ViewModelType = ItemViewModel
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        
        addSubviews()
        makeConstraints()
        
        LocalAppearance.mainViewApplyAppereance(view: self)
        
        showLoading()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        LocalAppearance.imageViewApplyAppereance(view: view)
        return view
    }()

    private let titleLabel: UILabel = {
        let l = UILabel()
        LocalAppearance.labelViewApplyAppereance(textLabel: l, level: LocalAppearance.TitleLabel.TitleFont.Level2)
        return l
    }()

    private let priceLabel: UILabel = {
        let l = UILabel()
        LocalAppearance.labelViewApplyAppereance(textLabel: l, level: LocalAppearance.TitleLabel.TitleFont.Level1)
        return l
    }()
    
    
    func configure(with item: ItemViewModel) {
        imageView.image = item.itemImage
        titleLabel.text = item.name
        priceLabel.text = "\(item.cost) ₽"
        if item.itemImage != nil{
            activityIndicator.stopAnimating()
        }
        else{
            activityIndicator.startAnimating()
        }
    }
    
    
    private func addSubviews(){
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(activityIndicator)
    }
    
    private func makeConstraints(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
