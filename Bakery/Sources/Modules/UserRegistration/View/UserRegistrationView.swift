//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

@MainActor
protocol UserRegistrationViewProtocol {
    func getInfo() -> UserRegistrationViewInfo
    func setup(with model: UserRegistrationViewModel)
    func configure(with model: UserRegistrationViewModel)
}

@MainActor
class UserRegistrationView: UIView, UserRegistrationViewProtocol {
    private var viewModel: UserRegistrationViewModel?
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        setupKeyboardObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with model: UserRegistrationViewModel){
        viewModel = model
        
        backgroundColor = model.style.backgroundColor
        
        let content = model.content
        contentView = ComponentFactory.makeView(from: content)
        
        guard let contentView else { return }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false

        self.subviews.forEach { $0.removeFromSuperview() }
        self.addSubview(contentView)
        bottomConstraint = contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        topConstraint = contentView.topAnchor.constraint(equalTo: self.topAnchor)
        topConstraint?.priority = UILayoutPriority(750)
        
        NSLayoutConstraint.activate([
            topConstraint!,
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomConstraint!,
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
        ])
    }
    
    
    func configure(with model: UserRegistrationViewModel){
        viewModel = model
        
        backgroundColor = model.style.backgroundColor
        
        let content = model.content
        
        guard contentView != nil else { return }
        
        contentView!.configure(with: content)
    }
    
    func getInfo() -> UserRegistrationViewInfo{
        let phoneField = contentView?.findView(withAccessibilityIdentifier: "phoneTextField")
        let nameField = contentView?.findView(withAccessibilityIdentifier: "nameTextField")
        
        var phoneInfo: DSTextFieldInfo = .init(text: "")
        var nameInfo: DSTextFieldInfo = .init(text: "")
        
        if phoneField != nil,  let field = phoneField as? DSTextField {
            phoneInfo = field.getInfo()
        }
        
        if nameField != nil,  let field = nameField as? DSTextField {
            nameInfo = field.getInfo()
        }

        return .init(phoneTextField : phoneInfo , nameTextField: nameInfo)
    }

    private var contentView : DSView?
 
    private var bottomConstraint: NSLayoutConstraint?
    private var topConstraint: NSLayoutConstraint?
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                        tapGesture.cancelsTouchesInView = false
                        addGestureRecognizer(tapGesture)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let kbFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }

        topConstraint?.isActive = false
        bottomConstraint?.constant = -kbFrame.height
        UIView.animate(withDuration: duration) {
            self.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }

        topConstraint?.isActive = true
        bottomConstraint?.constant = 0
        UIView.animate(withDuration: duration) {
            self.layoutIfNeeded()
        }
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
        topConstraint?.isActive = true
        bottomConstraint?.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
