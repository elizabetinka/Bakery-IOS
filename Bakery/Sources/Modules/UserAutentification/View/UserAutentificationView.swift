//
//  Created by Елизавета Кравченкова on 10/04/2025.
//

import UIKit

extension UserAutentificationView {
    struct Appearance {
        let exampleOffset: CGFloat = 10
    }
}

class UserAutentificationView: UIView {
    let appearance = Appearance()
    
    // Поле для ввода номера телефона
        private let phoneTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Введите номер телефона"
            textField.borderStyle = .roundedRect
            textField.keyboardType = .phonePad // показываем клавиатуру для ввода телефона
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
    
    private let loginButton: UIButton = {
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

    override init(frame: CGRect = CGRect.zero, delegate: ButtonDelegate) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        
        loginButton.addTarget(self, action: #selector(delegate), for: .touchUpInside)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews(){
        addSubview(customView)
    }

    func makeConstraints() {
    }
    
    
    @objc private func loginButtonTapped() {
            guard let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty else {
                print("Введите номер телефона")
                return
            }
            
            // Здесь можно реализовать логику аутентификации
            print("Введён номер телефона: \(phoneNumber)")
        }
}
