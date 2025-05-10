//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

protocol UserRegistrationViewProtocol : ViewProtocol {
    func showLoading()
    func showError(message: String)
    func validatedName(isValid: Bool)
    func validatedPhone(isValid: Bool)
}

class UserRegistrationView: UIView, UserRegistrationViewProtocol {
    private weak var buttonDelegate: RegistrationButtonDelegate?
    private weak var refreshActionsDelegate: ErrorViewDelegate?
    private weak var validateDelegate: UserRegistrationValidateDelegate?
    
    init(frame: CGRect = CGRect.zero, delegate: RegistrationButtonDelegate, refreshDelegate: ErrorViewDelegate, validateDelegate: UserRegistrationValidateDelegate) {
        
        self.buttonDelegate=delegate
        self.refreshActionsDelegate=refreshDelegate
        self.validateDelegate=validateDelegate
        
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        
        registerForKeyboardNotifications()
        
        Appearance.mainViewApplyAppereance(view: self)
        errorView.isHidden = true
    }
    
    func showLoading() {
        errorView.isHidden = true
    }
    
    func showError(message: String) {
        errorView.configure(withMessage: message)
        errorView.isHidden = false
    }
    
    func validatedName(isValid: Bool) {
        registrationButton.isEnabled = isValid
        Appearance.textFieldApplyAppereance(textField: nameTextField, isValid: isValid)
    }
    
    func validatedPhone(isValid: Bool) {
        registrationButton.isEnabled = isValid
        Appearance.textFieldApplyAppereance(textField: phoneTextField, isValid: isValid)
    }
    
    lazy private var errorView: ErrorView = ViewFactory.getErrorView(refreshDelegate: refreshActionsDelegate)
    lazy private var scrollView : UIScrollView =  ViewFactory.getScrollView()
    lazy private var logoImageView: UIImageView =  ViewFactory.getLogoImageView()
    lazy private var registrationTextLabel: UIView = ViewFactory.getTitleLable(title: "Регистрация", level: .Level1)
    lazy private var nameTextLabel: UIView = ViewFactory.getTitleLable(title: "Введите имя", level: .Level2)
    lazy private var nameTextField: UITextField = ViewFactory.getTextField(placeholder: "", onTextChanged: nameTextChanged)
    lazy private var phoneTextLabel: UIView = ViewFactory.getTitleLable(title: "Введите номер телефона", level: .Level2)
    lazy private var phoneTextField: UITextField = ViewFactory.getTextField(placeholder: "+7", onTextChanged: phoneTextChanged)
    lazy private var registrationButton: UIButton = ViewFactory.getButton(with: "Зарегистрироваться", onTap: registrationButtonTapped)

    
    lazy private var contentView: UIView = createContentView(registrationTextLabel: registrationTextLabel, nameTextLabel:nameTextLabel, nameTextField:nameTextField, phoneTextLabel:phoneTextLabel, phoneTextField:phoneTextField, registrationButton:registrationButton)
        
    
    private func addSubviews(){
        addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        scrollView.addSubview(logoImageView)
        scrollView.addSubview(contentView)
        scrollView.addSubview(errorView)
    }

    private func makeConstraints() {
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        errorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 170),
            logoImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            contentView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            
            errorView.widthAnchor.constraint(equalToConstant: 300),
            errorView.heightAnchor.constraint(equalToConstant: 200),
            errorView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            
        ])
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func nameTextChanged(_ textField: UITextField) {
        let text = textField.text ?? ""
        validateDelegate?.validateName(name: text)
    }
    
    @objc private func phoneTextChanged(_ textField: UITextField) {
        let text = textField.text ?? ""
        validateDelegate?.validatePhoneNumber(number: text)
    }

    
    @objc private func registrationButtonTapped() {
        guard let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty else {
            showError(message:"Введите номер телефона")
            return
        }
        guard let name = nameTextField.text, !name.isEmpty else {
            showError(message:"Введите Имя")
            return
        }
        
        buttonDelegate?.didTapRegistrationButton(number: phoneNumber, name: name )
    }
    
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tapGesture.cancelsTouchesInView = false
            addGestureRecognizer(tapGesture)
    }
    
    private var isKeyoardShown: Bool = false

        @objc private func keyboardWillShow(_ notification: Notification) {
            if let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                
                if !isKeyoardShown {
                    frame.origin.y -= keyboardFrame.height
                }
                isKeyoardShown = true
                
            }
        }

        @objc private func keyboardWillHide(_ notification: Notification) {
            frame.origin.y = 0
            isKeyoardShown = false
        }
    
        @objc private func dismissKeyboard() {
            endEditing(true)
            frame.origin.y = 0
            isKeyoardShown = false
        }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension UserRegistrationViewController: ErrorViewDelegate {
    func reloadButtonWasTapped() {
        display(newState: .loading)
    }
}
