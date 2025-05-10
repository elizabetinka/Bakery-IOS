//
//  errorView.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 10.04.2025.
//

import Foundation
import UIKit

extension ErrorView {
    struct LocalAppearance {
        static let borderWidth = 4.0
        static let borderColor = UIColor.appSoftPink.cgColor
        static let cornerRadius = 15
        
        static func mainViewApplyAppereance(view: UIView){
            Appearance.mainViewApplyAppereance(view: view)
            view.layer.borderWidth = 4.0
            view.layer.borderColor = UIColor.appSoftPink.cgColor
            view.layer.cornerRadius = 15
        }
    }
}


protocol ErrorViewDelegate: AnyObject {
    func reloadButtonWasTapped()
}

class ErrorView: UIView {

    weak var delegate: ErrorViewDelegate?

    lazy var title: UILabel = {
        let text = UILabel()
        text.text = "Uncnown error"
        Appearance.textLabelApplyAppereance(textLabel: text)
        return text
    }()
    
    lazy var refreshButton: UIButton = ViewFactory.getButton(with: "Try again", onTap: refreshButtonWasTapped)

    let appearance: Appearance

    init(frame: CGRect = CGRect.zero, appearance: Appearance = Appearance()) {
        self.appearance = appearance
        super.init(frame: frame)
        LocalAppearance.mainViewApplyAppereance(view: self)
        
        addSubviews()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        
        addSubview(title)
        addSubview(refreshButton)
    }

    func makeConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 20) ,
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
                    
            refreshButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            refreshButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
        
    }

    @objc func refreshButtonWasTapped() {
        delegate?.reloadButtonWasTapped()
    }
    
    func configure(withMessage errorMessage: String) {
        title.text = errorMessage
    }
}
