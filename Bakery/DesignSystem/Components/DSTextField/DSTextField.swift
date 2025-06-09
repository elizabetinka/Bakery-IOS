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
    }
    

    func configure(with viewModel: DSViewModel) {
        guard let viewModel = viewModel as? DSTextFieldViewModel else {
            fatalError("DSSpacer received wrong viewModel type")
        }
        self.viewModel = viewModel
        
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
        
        makeConfiguredConstraints(viewModel: viewModel)
    }
    
    
    func makeConfiguredConstraints(viewModel: DSTextFieldViewModel){
        let layout = viewModel.layout.padding
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: layout.hPadding, height: textField.frame.height))
        
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.topAnchor.constraint(equalTo: topAnchor, constant: layout.vPadding).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: layout.hPadding).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -layout.hPadding).isActive = true
        
        
        LayoutUtils.applyLayoutToView(layout: viewModel.errorLabel.layout.margin, view: errorLabel, topView: textField, botView: nil, superview: self)

        errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -layout.vPadding).isActive = true
    }
    
    func getInfo() -> DSTextFieldInfo {
        return DSTextFieldInfo(text: textField.text ?? "")
    }
    
    @objc private func editingChanged() {
        viewModel?.onEditingChanged?(textField.text ?? "")
    }
    
    
}
