//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

extension UserRegistrationView {
    struct Appearance {
        let exampleOffset: CGFloat = 10
        let backgroundColor: UIColor = .systemBackground
        let labelFont = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
}

class UserRegistrationView: UIView {
    let appearance = Appearance()
    var buttonDelegate: RegistrationButtonDelegate
    weak var refreshActionsDelegate: ErrorViewDelegate?
    
    lazy private var errorView: ErrorView = {
        let view = ErrorView()
            view.delegate = self.refreshActionsDelegate
            return view
    }()
    
    lazy private var scrollView = UIScrollView()
    
    lazy private var logoImageView: UIImageView = {
        let imageView = UIImageView(image: .logo)
        return imageView
    }()
    
    lazy private var registrationTextLabel: UIView = {
            let text =  UILabel()
            text.text = "Регистрация"
            text.textAlignment = .center
            text.textColor = .gray
            text.font = UIFont.systemFont(ofSize: 30, weight: .bold)
            text.translatesAutoresizingMaskIntoConstraints = false
        
            let mainView = UIView()
            mainView.translatesAutoresizingMaskIntoConstraints = false
            mainView.addSubview(text)
            text.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
            text.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
            mainView.heightAnchor.constraint(equalTo: text.heightAnchor, multiplier: 2).isActive = true
        
            return mainView
        }()
    
    lazy private var nameTextLabel: UIView = {
            let text =  UILabel()
            text.text = "Введите имя"
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
    
    lazy private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .namePhonePad
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.isUserInteractionEnabled = true
        textField.isEnabled = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        return textField
    }()
    
    lazy private var phoneTextLabel: UIView = {
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
        textField.keyboardType = .namePhonePad
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.isUserInteractionEnabled = true
        textField.isEnabled = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        return textField
    }()
    
    lazy private var registrationButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Зарегистрироваться", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor.systemBlue
            button.layer.cornerRadius = 8
            button.translatesAutoresizingMaskIntoConstraints = false
            //button.widthAnchor.constraint(equalToConstant: 80).isActive=true
            button.heightAnchor.constraint(equalToConstant: 40).isActive=true
            //button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
            var config = UIButton.Configuration.filled()
            config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
            button.configuration = config
            return button
        }()
    
    
    lazy private var contentView: UIView = {
        let stack = UIView()
        
        stack.addSubview(registrationTextLabel)
        stack.addSubview(nameTextLabel)
        stack.addSubview(nameTextField)
        stack.addSubview(phoneTextLabel)
        stack.addSubview(phoneTextField)
        stack.addSubview(registrationButton)
        
        registrationTextLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            registrationTextLabel.topAnchor.constraint(equalTo: stack.topAnchor),
            registrationTextLabel.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant:15),
            registrationTextLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -15),
            
            nameTextLabel.topAnchor.constraint(equalTo: registrationTextLabel.bottomAnchor, constant: 40),
            nameTextLabel.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant:15),
            nameTextLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -15),
            
            nameTextField.topAnchor.constraint(equalTo: nameTextLabel.bottomAnchor, constant: 10),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            nameTextField.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            
            phoneTextLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            phoneTextLabel.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant:15),
            phoneTextLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -15),
            
            phoneTextField.topAnchor.constraint(equalTo: phoneTextLabel.bottomAnchor, constant: 10),
            phoneTextField.heightAnchor.constraint(equalToConstant: 40),
            phoneTextField.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            
            registrationButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 80),
            registrationButton.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
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

    init(frame: CGRect = CGRect.zero, delegate: RegistrationButtonDelegate, refreshDelegate: ErrorViewDelegate) {
        buttonDelegate=delegate
        refreshActionsDelegate=refreshDelegate
        
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        
        backgroundColor = appearance.backgroundColor
        
        registerForKeyboardNotifications()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tapGesture.cancelsTouchesInView = false
            addGestureRecognizer(tapGesture)
        
        
        errorView.isHidden = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoading() {
        errorView.isHidden = true
    }
    
    func showError(message: String) {
        errorView.configure(withMessage: message)
        errorView.isHidden = false
    }

    
    @objc private func registrationButtonTapped() {
            guard let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty else {
                print("Введите номер телефона")
                showError(message:"Введите номер телефона")
                return
            }
            guard let name = nameTextField.text, !name.isEmpty else {
                print("Введите Имя")
                showError(message:"Введите Имя")
                return
            }
            
            // Здесь можно реализовать логику аутентификации
            print("Имя \(name) Введён номер телефона: \(phoneNumber)")
            buttonDelegate.didTapRegistrationButton(number: phoneNumber, name: name )
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
