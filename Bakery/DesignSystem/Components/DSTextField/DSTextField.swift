//
//  DSTextField.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 01.05.2025.
//

import UIKit

public final class DSTextField: UIView, DSView {
    
    private let textField = UITextField()
    private var viewModel: DSTextFieldViewModel?
    
    private var errorLabel =  DSLabel()
    
//    private lazy var errorLabel: UILabel = {
//        let lbl = UILabel()
//        lbl.font = UIFont.systemFont(ofSize: 12)
//        lbl.textColor = UIColor.appError
//        lbl.numberOfLines = 0
//        lbl.isHidden = true
//        return lbl
//    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        
        addSubview(textField)
        addSubview(errorLabel)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
//        NSLayoutConstraint.activate([
//            textField.topAnchor.constraint(equalTo: topAnchor, constant: HSpacing.s),
//            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: HSpacing.m),
//            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -HSpacing.m),
//            
//            errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: HSpacing.xs),
//            errorLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
//            errorLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
//            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -HSpacing.s)
//        ])
    }
    

    func configure(with viewModel: DSViewModel) {
        guard let viewModel = viewModel as? DSTextFieldViewModel else {
            fatalError("DSSpacer received wrong viewModel type")
        }
        self.viewModel = viewModel
        
//        textField.text = viewModel.text
//        if (viewModel.text != nil){
//            textField.becomeFirstResponder()
//        }
        textField.placeholder = viewModel.placeholder
        textField.font = viewModel.style.font
        textField.keyboardType = viewModel.style.keyboardType
        textField.layer.cornerRadius = viewModel.size.cornerRadius
        
        textField.textColor = viewModel.style.textColor(for: viewModel.state)
        textField.backgroundColor = viewModel.style.backgroundColor(for: viewModel.state)
        textField.layer.borderWidth = viewModel.style.borderWidth(for: viewModel.state)
        textField.layer.borderColor = viewModel.style.borderColor(for: viewModel.state)
        
        if let animation = viewModel.style.animation(for: viewModel.state){
            textField.layer.add(animation, forKey: "shake")
        }
        
        
        textField.heightAnchor.constraint(equalToConstant: viewModel.size.height).isActive = true
        
        if case .disabled = viewModel.state {
            textField.isEnabled = false
        }
        
        if case .hidden = viewModel.state {
            textField.isHidden = true
        }
        
        errorLabel.configure(with: viewModel.errorLabel)
        
        
        
        //switch viewModel.state {
//        case .error(let message):
//            errorLabel.text = message
//            errorLabel.isHidden = false
//        default:
//            errorLabel.isHidden = true
//        }
        
        //applyStyle()
        //applyErrorState()
        
        // Колбэк при вводе
        //textField.isUserInteractionEnabled = (viewModel.state != .disabled)
        
        
        //textField.font = UIFont.systemFont(ofSize: 16)
        makeConfiguredConstraints(viewModel: viewModel)
        
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
//        textField.leftView = paddingView
//        textField.leftViewMode = .always
    }
    
    
    func makeConfiguredConstraints(viewModel: DSTextFieldViewModel){
//        let all = self.constraints.filter {
//            $0.firstItem === textField || $0.firstItem === errorLabel
//        }
        
        //NSLayoutConstraint.deactivate(all)
        let layout = viewModel.layout.padding
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: layout.hPadding, height: textField.frame.height))
        
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.topAnchor.constraint(equalTo: topAnchor, constant: layout.vPadding).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: layout.hPadding).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -layout.hPadding).isActive = true
        
        //errorLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
        //errorLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
        
        applyLayoutToView(layout: viewModel.errorLabel.layout.margin, view: errorLabel, topView: textField, botView: nil, superview: self)
//        if let mrg = viewModel.errorLabel.layout.topMargin {
//            errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: mrg).isActive = true
//        }
//        
//        if viewModel.errorLabel.layout.width == .fill,  let mrg = viewModel.errorLabel.layout.hMargin {
//            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: mrg).isActive = true
//            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -mrg).isActive = true
//        }
        
        errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -layout.vPadding).isActive = true
        
        //print("textField \(textField.frame)")
        //print("errorLabel \(errorLabel.frame)")
//
//        errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -viewModel.layout.vPadding).isActive = true
//
////        button.contentEdgeInsets = UIEdgeInsets(top: viewModel.layout.vPadding, left: viewModel.layout.hPadding, bottom: viewModel.layout.vPadding, right: viewModel.layout.hPadding)
////        
////        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
////        button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
////        button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
////        button.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        
        //layoutIfNeeded()
    }
    
    func getInfo() -> DSTextFieldInfo {
        return DSTextFieldInfo(text: textField.text ?? "")
    }
    
    @objc private func editingChanged() {
        viewModel?.onEditingChanged?(textField.text ?? "")
    }
    
    
}

    // Применяем фон, рамку и скругления
//    private func applyStyle() {
//        let style = viewModel.style
//        let state = viewModel.state
//
//        backgroundColor = style.backgroundColor(for: state)
//        layer.cornerRadius = style.cornerRadius
//        layer.borderWidth = style.borderWidth(for: state)
//        layer.borderColor = style.borderColor(for: state).cgColor

        // Плейсхолдер-атрибут
//        let placeholderAttr = NSAttributedString(
//            string: viewModel.placeholder,
//            attributes: [.foregroundColor: viewModel.style.placeholderColor]
//        )
//        textField.attributedPlaceholder = placeholderAttr
//    }

    // Показ/скрытие errorLabel
//    private func applyErrorState() {
//        switch viewModel.state {
//        case .error(let message):
//            errorLabel.text = message
//            errorLabel.isHidden = false
//        default:
//            errorLabel.isHidden = true
//        }
//    }

    // MARK: — Обработка ввода

