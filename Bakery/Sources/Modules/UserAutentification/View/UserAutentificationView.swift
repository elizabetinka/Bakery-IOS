//
//  Created by Елизавета Кравченкова on 10/04/2025.
//

import UIKit

@MainActor
protocol UserAutentificationViewProtocol : ViewProtocol {
    func showLoading()
    func showError(message: String)
    func updateUI(isValid: Bool)
}

@MainActor
class UserAutentificationView: UIView, UserAutentificationViewProtocol {
    
    private weak var buttonDelegate: LoginButtonDelegate?
    private weak var refreshActionsDelegate: ErrorViewDelegate?
    private weak var validateDelegate: UserAutentificationValidateDelegate?
    

    init(frame: CGRect = CGRect.zero, delegate: LoginButtonDelegate, refreshDelegate: ErrorViewDelegate, validateDelegate: UserAutentificationValidateDelegate) {
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
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopError() {
        errorView.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func showError(message: String) {
        activityIndicator.stopAnimating()
        errorView.configure(withMessage: message)
        errorView.isHidden = false
    }
    
    func updateUI(isValid: Bool) {
        loginButton.isEnabled = isValid
        Appearance.textFieldApplyAppereance(textField: phoneTextField, isValid: isValid)
    }
    
    lazy private var activityIndicator : UIActivityIndicatorView = ViewFactory.getActivityIndicator()
    lazy private var scrollView : UIScrollView =  ViewFactory.getScrollView()
    lazy private var logoImageView: UIImageView =  ViewFactory.getLogoImageView()
    lazy private var textLabel: UIView = ViewFactory.getTitleLable(title: "Введите номер телефона")
    lazy private var phoneTextField: UITextField = ViewFactory.getTextField(placeholder: "+7", onTextChanged: phoneTextChanged)
    lazy private var loginButton: UIButton = ViewFactory.getButton(with: "Войти", onTap: loginButtonTapped)
    lazy private var errorView: ErrorView = ViewFactory.getErrorView(refreshDelegate: refreshActionsDelegate)
    lazy private var contentView: UIView = createContentView(textLabel: textLabel, phoneTextField: phoneTextField, loginButton: loginButton)
    
    
    func addSubviews(){
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
        scrollView.addSubview(activityIndicator)
    }

    func makeConstraints() {
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        errorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 170),
            logoImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            contentView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 150),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            

            errorView.widthAnchor.constraint(equalToConstant: 300),
            errorView.heightAnchor.constraint(equalToConstant: 200),
            errorView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
    
    }
    
    @objc private func loginButtonTapped() {
        guard let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty else {
            showError(message: "Введите номер телефона")
            return
        }
        buttonDelegate?.didTapLoginButton(number: phoneNumber)
    }
    
    @objc private func phoneTextChanged(_ textField: UITextField) {
        let text = textField.text ?? ""
        validateDelegate?.validatePhoneNumber(number: text)
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
    
}


