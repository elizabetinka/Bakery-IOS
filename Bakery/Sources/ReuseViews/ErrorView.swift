//
//  errorView.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 10.04.2025.
//

import Foundation
import UIKit


protocol ErrorViewDelegate: AnyObject {
    func reloadButtonWasTapped()
}

/// Вью для состояния ошибки сетевого запроса
class ErrorView: UIView {
    class Appearance {
        let titleColor = UIColor.black

        let backgroundColor = UIColor.white
        let buttonCornerRadius: CGFloat = 4
        let buttonTitleColor = UIColor.darkGray
        let buttonTitleHighlightedColor = UIColor.lightGray
        let buttonBackgroundColor : UIColor = .appPink

        let titleInsets = UIEdgeInsets(top: 0.35, left: 33, bottom: 0, right: 32)
        let refreshButtonInsets = UIEdgeInsets(top: 24, left: 88, bottom: 0, right: 87)
        let refreshButtonHeight: CGFloat = 48

        let buttonText = "Try again"
    }

    weak var delegate: ErrorViewDelegate?

    lazy var title: UILabel = {
        let text = UILabel()
        text.textColor = self.appearance.titleColor
        text.textAlignment = .center
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        text.text = "Uncnown error"
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        text.adjustsFontSizeToFitWidth = false
    
        return text
    }()
    
    lazy var titleView: UIView = {
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(title)
        
        title.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
        title.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
        title.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
        
        mainView.heightAnchor.constraint(equalTo: title.heightAnchor, multiplier: 2).isActive = true
        
        mainView.clipsToBounds = true
        
        return mainView
    }()

    lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.setTitle(self.appearance.buttonText, for: .normal)
        button.setTitleColor(self.appearance.buttonTitleColor, for: .normal)
        button.setTitleColor(self.appearance.buttonTitleHighlightedColor, for: .highlighted)
        button.addTarget(self, action: #selector(refreshButtonWasTapped), for: .touchUpInside)
        
        button.backgroundColor = appearance.buttonBackgroundColor
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 80).isActive=true
        button.heightAnchor.constraint(equalToConstant: 40).isActive=true
        return button
    }()

    let appearance: Appearance

    init(frame: CGRect = CGRect.zero, appearance: Appearance = Appearance()) {
        self.appearance = appearance
        super.init(frame: frame)
        print("Error view init")
        backgroundColor = appearance.backgroundColor
        layer.borderWidth = 4.0
        layer.borderColor = UIColor.appSoftPink.cgColor
        layer.cornerRadius = 15
        addSubviews()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        
        addSubview(titleView)
        addSubview(refreshButton)
    }

    func makeConstraints() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
//            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            titleView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: 20) ,
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    
            //refreshButton.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 25),
            refreshButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            refreshButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
                ])
        
//        NSLayoutConstraint.activate([
//            mainView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            mainView.centerYAnchor.constraint(equalTo: centerYAnchor),
//        ])
//        title.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.left.equalToSuperview().offset(appearance.titleInsets.left)
//            make.right.equalToSuperview().offset(-appearance.titleInsets.right)
//        }
//
//        refreshButton.snp.makeConstraints { make in
//            make.centerX.equalTo(title.snp.centerX)
//            make.top.equalTo(title.snp.bottom).offset(appearance.refreshButtonInsets.top)
//        }
    }

    @objc
    func refreshButtonWasTapped() {
        delegate?.reloadButtonWasTapped()
    }
    
    func configure(withMessage errorMessage: String) {
            print("Error configure")
            title.text = errorMessage
        }
}
