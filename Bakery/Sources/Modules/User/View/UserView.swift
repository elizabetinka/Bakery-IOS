//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

extension UserView {
    struct Appearance {
        let exampleOffset: CGFloat = 10
        let backgroundColor = UIColor.white
        let labelFont = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
}

class UserView: UIView {
    let appearance = Appearance()
    weak var refreshActionsDelegate: ErrorViewDelegate?


    init(frame: CGRect = CGRect.zero, refreshDelegate: ErrorViewDelegate) {
        refreshActionsDelegate=refreshDelegate
        super.init(frame: frame)
        backgroundColor=appearance.backgroundColor
        addSubviews()
        makeConstraints()
        
        errorView.isHidden = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var errorView: ErrorView = {
        let view = ErrorView()
            view.delegate = self.refreshActionsDelegate
            return view
    }()
    
    lazy private var scrollView = UIScrollView()
    
    lazy private var nameTextLabel: UILabel = {
            let text =  UILabel()
            text.text = "Неизвестно"
            text.textAlignment = .center
            text.textColor = .gray
            text.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            text.translatesAutoresizingMaskIntoConstraints = false
        
            return text
        }()
    
    lazy private var nameTextView: UIView = {
        
            let mainView = UIView()
            mainView.translatesAutoresizingMaskIntoConstraints = false
            mainView.addSubview(nameTextLabel)
            nameTextLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
            nameTextLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
            mainView.heightAnchor.constraint(equalTo: nameTextLabel.heightAnchor, multiplier: 2).isActive = true
        
            return mainView
        }()
    
    lazy private var phoneTextLabel: UILabel = {
            let text =  UILabel()
            text.text = "+0(000)000-00-00"
            text.textAlignment = .center
            text.textColor = .gray
            text.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            text.translatesAutoresizingMaskIntoConstraints = false
            return text
        }()
    
    lazy private var phoneTextView: UIView = {
    
            let mainView = UIView()
            mainView.translatesAutoresizingMaskIntoConstraints = false
            mainView.addSubview(phoneTextLabel)
            phoneTextLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
            phoneTextLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
            mainView.heightAnchor.constraint(equalTo: phoneTextLabel.heightAnchor, multiplier: 2).isActive = true
        
            return mainView
        }()
    
    lazy private var pointsTextLabel: UILabel = {
            let text =  UILabel()
            text.text = "0 бонусов"
            text.textAlignment = .center
            text.textColor = .gray
            text.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            text.translatesAutoresizingMaskIntoConstraints = false
            return text
        }()
    
    lazy private var pointsTextView: UIView = {
    
            let mainView = UIView()
            mainView.translatesAutoresizingMaskIntoConstraints = false
            mainView.addSubview(pointsTextLabel)
            pointsTextLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
            pointsTextLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
            mainView.heightAnchor.constraint(equalTo: pointsTextLabel.heightAnchor, multiplier: 2).isActive = true
        
            return mainView
        }()
    
    
    lazy private var contentView: UIView = {
        let stack = UIView()
        
        stack.addSubview(nameTextView)
        stack.addSubview(phoneTextView)
        stack.addSubview(pointsTextView)
        
        nameTextView.translatesAutoresizingMaskIntoConstraints = false
        phoneTextView.translatesAutoresizingMaskIntoConstraints = false
        pointsTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           
            nameTextView.topAnchor.constraint(equalTo: stack.topAnchor),
            nameTextView.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant:15),
            nameTextView.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -15),
            
            phoneTextView.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: 30),
            phoneTextView.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant:15),
            phoneTextView.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -15),
            
            pointsTextView.topAnchor.constraint(equalTo: phoneTextView.bottomAnchor, constant: 30),
            pointsTextView.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant:15),
            pointsTextView.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -15),
    
        ])
        
        
        return stack
    }()

    func addSubviews(){
        addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        scrollView.addSubview(contentView)
        scrollView.addSubview(errorView)
    }

    func makeConstraints() {
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        errorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           
            contentView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 50),
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
    
    func showLoading() {
        errorView.isHidden = true
    }
    
    func showError(message: String) {
        errorView.configure(withMessage: message)
        errorView.isHidden = false
    }

    
    func presentUserInfo(userInfo : UserInfoViewModel){
        nameTextLabel.text = userInfo.name
        phoneTextLabel.text = userInfo.phoneNumber
        pointsTextLabel.text = "\(userInfo.points) бонусов"
    }
}

extension UserViewController: ErrorViewDelegate {
    func reloadButtonWasTapped() {
        display(newState: .loading)
    }
}
