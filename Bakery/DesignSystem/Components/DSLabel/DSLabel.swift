//
//  DSLabel.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 03.05.2025.
//

import UIKit

final class DSLabel : UIView, DSView {
    private var viewModel: DSLabelViewModel?
    private var label = UILabel()
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        addSubview(label)
        self.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }


    func configure(with viewModel: DSViewModel) {
        guard let viewModel = viewModel as? DSLabelViewModel else {
            fatalError("DSSpacer received wrong viewModel type")
        }
        print("configure label \(viewModel.text)")
        self.viewModel = viewModel
        
        label.text = viewModel.text
        
        label.textColor = viewModel.style.textColor()
        label.numberOfLines = viewModel.style.numberOfLines
        label.lineBreakMode = viewModel.style.lineBreakMode
        label.adjustsFontSizeToFitWidth = viewModel.style.adjustsFontSizeToFitWidth
        label.textAlignment = viewModel.style.textAlignment(for: viewModel.style)
        
        label.font = viewModel.size.font(for: viewModel.style)

        label.isHidden = viewModel.state == .hidden
        
        makeConfiguredConstraints(viewModel: viewModel)
        //invalidateIntrinsicContentSize()
    }
    
    func makeConfiguredConstraints(viewModel: DSLabelViewModel){
//        let all = self.constraints.filter {
//            $0.firstItem === label
//        }
        
        let layout = viewModel.layout.padding
        
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: layout.vPadding).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: layout.vPadding).isActive = true
        
        
        label.textAlignment = viewModel.style.textAlignment(for: viewModel.style)
        
        switch label.textAlignment {
        case .left:
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: layout.hPadding).isActive = true
            label.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -layout.hPadding).isActive = true
        case .right:
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -layout.hPadding).isActive = true
            label.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: layout.hPadding).isActive = true
        default:
            //label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: layout.hPadding).isActive = true
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -layout.hPadding).isActive = true
        }
        
//        self.widthAnchor
//            .constraint(equalTo: label.widthAnchor, constant: layout.hPadding * 2)
//            .isActive = true
//        
//        self.heightAnchor
//            .constraint(equalTo: label.heightAnchor, constant: layout.vPadding * 2)
//            .isActive = true
        
        //layoutIfNeeded()
    }
    
//
//override var intrinsicContentSize: CGSize {
//    guard let viewModel = viewModel else {
//        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
//    }
//
//    let layout = viewModel.layout.padding
//    return CGSize(
//        width: label.intrinsicContentSize.width + 2 * layout.hPadding,
//        height: label.intrinsicContentSize.height + 2 * layout.vPadding
//    )
//}
    
//    func makeConfiguredConstraints(viewModel: DSLabelViewModel) {
//        let labelLayout = viewModel.layout
//        
//        if labelLayout.width == .fill,  let mrg = labelLayout.hMargin {
//            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: mrg).isActive = true
//            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -mrg).isActive = true
//        }
//        if loginButtonLayout?.hAlign == .center {
//            loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        }
//        if loginButtonLayout?.vAlign == .center {
//            loginButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//        }
//        if let mrg = loginButtonLayout?.topMargin {
//            loginButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: mrg).isActive = true
//        }
//        if let mrg = loginButtonLayout?.bottomMargin {
//            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -mrg).isActive = true
//        }
//    }
    
    
//    func applyAligment(alignment: NSTextAlignment){
//        switch alignment {
//        case .left:
//            label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = false
//            label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//            label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = false
//        case .right:
//            label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = false
//            label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = false
//            label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        default:
//            label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//            label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = false
//            label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = false
//        }
//    }
}
