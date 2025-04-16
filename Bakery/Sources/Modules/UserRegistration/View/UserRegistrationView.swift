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
    
    // Поле для ввода номера телефона
        private let phoneTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Введите номер телефона"
            textField.borderStyle = .roundedRect
            textField.keyboardType = .phonePad // показываем клавиатуру для ввода телефона
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
    
    // Поле для ввода номера имени
        private let nameTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Введите имя"
            textField.borderStyle = .roundedRect
            textField.keyboardType = .phonePad // показываем клавиатуру для ввода телефона
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
    
    private let registrationButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Войти", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor.systemBlue
            button.layer.cornerRadius = 8
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

    fileprivate(set) lazy var customView: UIView = {
        let view = UIView()
        return view
    }()


    init(frame: CGRect = CGRect.zero, delegate: RegistrationButtonDelegate) {
        buttonDelegate=delegate
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews(){
        addSubview(customView)
    }

    func makeConstraints() {
    }
    
    func showError(message: String) {
    }
    
    @objc private func registrationButtonTapped() {
            guard let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty else {
                print("Введите номер телефона")
                return
            }
            guard let name = nameTextField.text, !name.isEmpty else {
                print("Введите Имя")
                return
            }
            
            // Здесь можно реализовать логику аутентификации
            print("Имя \(name) Введён номер телефона: \(phoneNumber)")
            buttonDelegate.didTapRegistrationButton(number: phoneNumber, name: name )
        }
}
