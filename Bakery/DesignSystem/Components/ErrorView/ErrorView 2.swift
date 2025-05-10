//
//  errorView.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 10.04.2025.
//

import Foundation
import UIKit

//extension ErrorView {
//    struct LocalAppearance {
//        static let borderWidth = 4.0
//        static let borderColor = UIColor.appSoftPink.cgColor
//        static let cornerRadius = 15
//        
//        static func mainViewApplyAppereance(view: UIView){
//            Appearance.mainViewApplyAppereance(view: view)
//            view.layer.borderWidth = 4.0
//            view.layer.borderColor = UIColor.appSoftPink.cgColor
//            view.layer.cornerRadius = 15
//        }
//    }
//}
//
//
//protocol ErrorViewDelegate: AnyObject {
//    func reloadButtonWasTapped()
//}
//
//class ErrorView: UIView, DSView  {
//
//    weak var delegate: ErrorViewDelegate?
//
////    lazy var title: UILabel = {
////        let text = UILabel()
////        text.text = "Uncnown error"
////        Appearance.textLabelApplyAppereance(textLabel: text)
////        return text
////    }()
//    
//    var title = DSLabel()
//    
//    //lazy var refreshButton: UIButton = ViewFactory.getButton(with: "Try again", onTap: refreshButtonWasTapped)
//    var refreshButton = DSButton()
//
//    let appearance: Appearance
//
//    init(frame: CGRect = CGRect.zero, appearance: Appearance = Appearance()) {
//        self.appearance = appearance
//        super.init(frame: frame)
//        LocalAppearance.mainViewApplyAppereance(view: self)
//        
//        addSubviews()
//        makeConstraints()
//        
//        //isUserInteractionEnabled = true
//        //refreshButton.isUserInteractionEnabled = true
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configure(with viewModel: DSViewModel) {
//        guard let viewModel = viewModel as? ErrorViewModel else {
//            fatalError("DSSpacer received wrong viewModel type")
//        }
//        
//        self.layer.borderWidth = viewModel.style.borderWidth
//        self.layer.borderColor = viewModel.style.borderColor
//        self.layer.cornerRadius = viewModel.style.cornerRadius
//        
//        if let vm = model.refreshButton{
//            refreshButton.configure(with: vm)
//        }
//        if let vm = model.title{
//            title.configure(with: vm)
//        }
//        
////        if case .hidden = model.state {
////            isHidden = true
////        }
//        isHidden = model.state == .hidden
//        
////        if case let .error(message: message) = model.state {
////            isHidden = false
////            title.text = message
////        }
//        
//        makeConfiguredConstraints(viewModel: model)
//    }
//
//    func addSubviews() {
//        
//        addSubview(title)
//        addSubview(refreshButton)
//    }
//
//    func makeConstraints() {
//        //translatesAutoresizingMaskIntoConstraints = false
//        title.translatesAutoresizingMaskIntoConstraints = false
//        refreshButton.translatesAutoresizingMaskIntoConstraints = false
//
//    }
//    
//    func makeConfiguredConstraints(viewModel: ErrorViewModel) {
//        
////        let all = title.constraints.filter {
////            $0.firstItem === refreshButton || $0.secondItem === refreshButton
////        }
////        NSLayoutConstraint.deactivate(all)
//        //print("error title \(title.frame)")
//        
//        //NSLayoutConstraint.deactivate(self.constraints)
//        
//        if let titleLayout = viewModel.title?.layout {
//            applyLayoutToView(layout: titleLayout.margin, view: title, topView: nil, botView: refreshButton, superview: self)
//        }
//        
//        if let buttonLayout = viewModel.refreshButton?.layout {
//            applyLayoutToView(layout: buttonLayout.margin, view: refreshButton, topView: title, botView: nil, superview: self)
//        }
//        
//        //title.layoutIfNeeded()
//    }
//    
////    func applyLayoutToView(layout: DSLayout, view: UIView, topView: UIView?, botView: UIView?, superview: UIView){
////        let all = superview.constraints.filter {
////            $0.firstItem === view
////        }
////        NSLayoutConstraint.deactivate(all)
////        
////        if layout.width == .fill,  let mrg = layout.hMargin {
////            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: mrg).isActive = true
////            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -mrg).isActive = true
////        }
////        if layout.hAlign == .center {
////            view.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
////        }
////        if layout.vAlign == .center {
////            view.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
////        }
////        if let mrg = layout.topMargin {
////            if let topView = topView {
////                view.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: mrg).isActive = true
////            }
////            else{
////                view.topAnchor.constraint(equalTo: superview.topAnchor, constant: mrg).isActive = true
////            }
////        }
////        if let mrg = layout.bottomMargin {
////            if let botView = botView {
////                view.bottomAnchor.constraint(equalTo: botView.topAnchor, constant: -mrg).isActive = true
////            }
////            else{
////                view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -mrg).isActive = true
////            }
////        }
////        
////        superview.layoutIfNeeded()
////    }
//    
////    func applyLayoutToView(layout: DSLayout, view: UIView, topView: UIView, botView: UIView, superview: UIView){
////        let all = superview.constraints.filter {
////            $0.firstItem === view
////        }
////        NSLayoutConstraint.deactivate(all)
////        
////        if layout.width == .fill,  let mrg = layout.hMargin {
////            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: mrg).isActive = true
////            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -mrg).isActive = true
////        }
////        if layout.hAlign == .center {
////            view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
////        }
////        if layout.vAlign == .center {
////            view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
////        }
////        if let mrg = layout.topMargin {
////            view.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: mrg).isActive = true
////        }
////        if let mrg = layout.bottomMargin {
////            view.bottomAnchor.constraint(equalTo: botView.bottomAnchor, constant: -mrg).isActive = true
////        }
////        
////        self.layoutIfNeeded()
////    }
//
//    @objc func refreshButtonWasTapped() {
//        delegate?.reloadButtonWasTapped()
//    }
//    
//    func configure(withMessage errorMessage: String) {
//        //title.text = errorMessage
//    }
//}
//
//
//
////        NSLayoutConstraint.activate([
////            title.topAnchor.constraint(equalTo: topAnchor, constant: VSpacing.m) ,
////            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: HSpacing.l),
////            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -HSpacing.l),
////
////            //refreshButton.centerXAnchor.constraint(equalTo: centerXAnchor),
//////            refreshButton.topAnchor.constraint(equalTo: title.bottomAnchor, constant: VSpacing.l),
//////            refreshButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -VSpacing.s),
//////            refreshButton.centerXAnchor.constraint(equalTo: centerXAnchor),
//////            refreshButton.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: HSpacing.l),
//////            refreshButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -HSpacing.l),
////
////            //heightAnchor.constraint(equalToConstant: 200)
////        ])
//
////self.layoutIfNeeded()
//
////        if let labelLayout = viewModel {
////            applyLayoutToView(layout: labelLayout, view: textLabel, topView: logoImageView, botView: loginButton, superview: contentView)
////        }
//
////        let all = self.constraints.filter {
////            $0.firstItem === refreshButton
////        }
////        NSLayoutConstraint.deactivate(all)
////
////        let buttonLayout = viewModel.refreshButton?.layout
////
////        if buttonLayout?.width == .fill,  let mrg = buttonLayout?.hMargin {
////            refreshButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: mrg).isActive = true
////            refreshButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -mrg).isActive = true
////        }
////        if buttonLayout?.hAlign == .center {
////            refreshButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
////        }
////        if buttonLayout?.vAlign == .center {
////            refreshButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
////        }
////        if let mrg = buttonLayout?.topMargin {
////            refreshButton.topAnchor.constraint(equalTo: title.bottomAnchor, constant: mrg).isActive = true
////        }
////        if let mrg = buttonLayout?.bottomMargin {
////            refreshButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -mrg).isActive = true
////        }
////
////        self.layoutIfNeeded()
