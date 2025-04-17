//
//  Created by Елизавета Кравченкова on 10/04/2025.
//

import UIKit

extension UserAutentificationView {
    struct Appearance {
        let exampleOffset: CGFloat = 10
        let backgroundColor: UIColor = .white
        let labelFont = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
}

class UserAutentificationView: UIView {
    let appearance = Appearance()
    
    weak var buttonDelegate: LoginButtonDelegate?
    weak var refreshActionsDelegate: ErrorViewDelegate?
    
    lazy var errorView: ErrorView = {
        let view = ErrorView()
            view.delegate = self.refreshActionsDelegate
            return view
    }()
    

    init(frame: CGRect = CGRect.zero, delegate: LoginButtonDelegate, refreshDelegate: ErrorViewDelegate) {
        buttonDelegate=delegate
        refreshActionsDelegate=refreshDelegate
        
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        backgroundColor = appearance.backgroundColor
        
        registerForKeyboardNotifications()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tapGesture.cancelsTouchesInView = false
            addGestureRecognizer(tapGesture)
        
        
        errorView.isHidden = true
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

    func showLoading() {
        errorView.isHidden = true
        phoneTextField.placeholder = "+7"
    }
    
    func showError(message: String) {
        errorView.configure(withMessage: message)
        errorView.isHidden = false
    }
    
    
    @objc private func loginButtonTapped() {
        guard let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty else {
            print("Введите номер телефона")
            showError(message: "Введите номер телефона")
            return
        }
            
            // Здесь можно реализовать логику аутентификации
        print("Введён номер телефона: \(phoneNumber)")
        buttonDelegate?.didTapLoginButton(number: phoneNumber)
    }
    
    
    
    lazy private var scrollView = UIScrollView()
    
    lazy private var logoImageView: UIImageView = {
        let imageView = UIImageView(image: .logo)
        return imageView
    }()
    
    lazy private var textLabel: UIView = {
            let text =  UILabel()
            text.text = "Введите номер телефона"
            text.textAlignment = .center
            text.textColor = .gray
            text.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            text.translatesAutoresizingMaskIntoConstraints = false
        
            let mainView = UIView()
            mainView.translatesAutoresizingMaskIntoConstraints = false
            mainView.addSubview(text)
            text.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
            text.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
            mainView.heightAnchor.constraint(equalTo: text.heightAnchor, multiplier: 2).isActive = true
        
            return mainView
        }()
    
    lazy private var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "+7"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.isUserInteractionEnabled = true
        textField.isEnabled = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        return textField
    }()
    
    lazy private var loginButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Войти", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor.systemBlue
            button.layer.cornerRadius = 8
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 80).isActive=true
            button.heightAnchor.constraint(equalToConstant: 40).isActive=true
            return button
        }()
    
    
    lazy private var contentView: UIView = {
        let stack = UIView()
        
        stack.addSubview(textLabel)
        stack.addSubview(phoneTextField)
        stack.addSubview(loginButton)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: stack.topAnchor),
            textLabel.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant:15),
            textLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -15),
            
            phoneTextField.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 50),
            phoneTextField.heightAnchor.constraint(equalToConstant: 40),
            phoneTextField.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
        ])
        
        
        return stack
    }()
    
    
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
            
            contentView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 150),
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
        }

        @objc private func keyboardWillShow(_ notification: Notification) {
            if let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                frame.origin.y -= keyboardFrame.height
            }
        }

        @objc private func keyboardWillHide(_ notification: Notification) {
            frame.origin.y = 0
        }
    
        @objc private func dismissKeyboard() {
            endEditing(true)
            frame.origin.y = 0
        }
    
}
