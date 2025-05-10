//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

//import UIKit
//
//@MainActor
//protocol UserRegistrationViewProtocol : ViewProtocol {
//    //func showLoading()
//    //func showError(message: String)
//    //func validatedName(isValid: Bool)
//    //func validatedPhone(isValid: Bool)
//    func getInfo() -> UserRegistrationViewInfo
//    func setup(with model: UserRegistrationViewModel)
//    func configure(with model: UserRegistrationViewModel)
//}
//
//@MainActor
//class UserRegistrationView: UIView, UserRegistrationViewProtocol {
//    private var viewModel: UserRegistrationViewModel?
//    
//    override init(frame: CGRect = CGRect.zero) {
//        super.init(frame: frame)
//        //addSubviews()
//        //makeConstraints()
//        
//        //registerForKeyboardNotifications()
//        setupKeyboardObservers()
//        //Appearance.mainViewApplyAppereance(view: self)
//        //errorView.isHidden = true
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setup(with model: UserRegistrationViewModel){
//        viewModel = model
//        
//        backgroundColor = model.style.backgroundColor
//        
//        let content = model.content
//        contentView = ComponentFactory.makeView(from: content)
//        
//        guard let contentView else { return }
//        
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//
//        self.subviews.forEach { $0.removeFromSuperview() }
//        self.addSubview(contentView)
//        bottomConstraint = contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//        topConstraint = contentView.topAnchor.constraint(equalTo: self.topAnchor)
//        
//        NSLayoutConstraint.activate([
//            topConstraint!,
//            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            bottomConstraint!,
//            contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
//        ])
//    }
//    
//    
//    func configure(with model: UserRegistrationViewModel){
//        viewModel = model
//        
//        backgroundColor = model.style.backgroundColor
//        
//        let content = model.content
//        
//        guard contentView != nil else { return }
//        
//        contentView!.configure(with: content)
//    }
//    
//    func getInfo() -> UserRegistrationViewInfo{
//        let phoneField = contentView?.findView(withAccessibilityIdentifier: "phoneTextField")
//        let nameField = contentView?.findView(withAccessibilityIdentifier: "nameTextField")
//        
//        var phoneInfo: DSTextFieldInfo = .init(text: "")
//        var nameInfo: DSTextFieldInfo = .init(text: "")
//        
//        if phoneField != nil,  let field = phoneField as? DSTextField {
//            phoneInfo = field.getInfo()
//        }
//        
//        if nameField != nil,  let field = nameField as? DSTextField {
//            nameInfo = field.getInfo()
//        }
//
//        return .init(phoneTextField : phoneInfo , nameTextField: nameInfo)
//    }
//    
//    func showLoading() {
//        //activityIndicator.startAnimating()
//    }
//    
//    func stopError() {
////        errorView.isHidden = true
////        activityIndicator.stopAnimating()
//    }
//    
//    func showError(message: String) {
////        activityIndicator.stopAnimating()
////        errorView.configure(withMessage: message)
////        errorView.isHidden = false
//    }
//    
////    func validatedName(isValid: Bool) {
////        registrationButton.isEnabled = isValid
////        Appearance.textFieldApplyAppereance(textField: nameTextField, isValid: isValid)
////    }
////    
////    func validatedPhone(isValid: Bool) {
////        registrationButton.isEnabled = isValid
////        Appearance.textFieldApplyAppereance(textField: phoneTextField, isValid: isValid)
////    }
//    
////    lazy private var activityIndicator : UIActivityIndicatorView = ViewFactory.getActivityIndicator()
////    lazy private var errorView: ErrorView = ViewFactory.getErrorView(refreshDelegate: refreshActionsDelegate)
////    lazy private var scrollView : UIScrollView =  ViewFactory.getScrollView()
////    lazy private var logoImageView: UIImageView =  ViewFactory.getLogoImageView()
////    lazy private var registrationTextLabel: UIView = ViewFactory.getTitleLable(title: "Регистрация", level: .Level1)
////    lazy private var nameTextLabel: UIView = ViewFactory.getTitleLable(title: "Введите имя", level: .Level2)
////    lazy private var nameTextField: UITextField = ViewFactory.getTextField(placeholder: "", onTextChanged: nameTextChanged)
////    lazy private var phoneTextLabel: UIView = ViewFactory.getTitleLable(title: "Введите номер телефона", level: .Level2)
////    lazy private var phoneTextField: UITextField = ViewFactory.getTextField(placeholder: "+7", onTextChanged: phoneTextChanged)
////    lazy private var registrationButton: UIButton = ViewFactory.getButton(with: "Зарегистрироваться", onTap: registrationButtonTapped)
//    
////    private lazy var logoImageView  =  DSImage()
////    private lazy var activityIndicator = DSActivityIndicator()
////    private lazy var registrationTextLabel = DSLabel()
////    private lazy var nameTextLabel = DSLabel()
////    private lazy var phoneTextLabel = DSLabel()
////    private lazy var registrationButton = DSButton()
////    private lazy var nameTextField = DSTextField()
////    private lazy var phoneTextField = DSTextField()
////    private lazy var errorView = ErrorView()
////    private lazy var emptyView = UIView()
//    private var contentView :DSView?
// 
//    private var bottomConstraint: NSLayoutConstraint?
//    private var topConstraint: NSLayoutConstraint?
//    
////    lazy private var contentView: UIView = createContentView(registrationTextLabel: registrationTextLabel, nameTextLabel:nameTextLabel, nameTextField:nameTextField, phoneTextLabel:phoneTextLabel, phoneTextField:phoneTextField, registrationButton:registrationButton)
//        
//    
////    func addSubviews(){
////        self.addSubview(contentView)
////        
////        contentView.addSubview(logoImageView)
////        contentView.addSubview(registrationTextLabel)
////        contentView.addSubview(nameTextLabel)
////        contentView.addSubview(nameTextField)
////        contentView.addSubview(phoneTextLabel)
////        contentView.addSubview(phoneTextField)
////        contentView.addSubview(registrationButton)
////        contentView.addSubview(emptyView)
////        contentView.addSubview(errorView)
////        contentView.addSubview(activityIndicator)
////    }
////
////    func makeConstraints() {
////        
////        contentView.translatesAutoresizingMaskIntoConstraints = false
////
////        bottomConstraint = contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
////        topConstraint = contentView.topAnchor.constraint(equalTo: self.topAnchor)
////        
////        NSLayoutConstraint.activate([
////            topConstraint!,
////            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
////            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
////            bottomConstraint!,
////            contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
////        ])
////        logoImageView.translatesAutoresizingMaskIntoConstraints = false
////        registrationTextLabel.translatesAutoresizingMaskIntoConstraints = false
////        nameTextLabel.translatesAutoresizingMaskIntoConstraints = false
////        nameTextField.translatesAutoresizingMaskIntoConstraints = false
////        phoneTextLabel.translatesAutoresizingMaskIntoConstraints = false
////        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
////        registrationButton.translatesAutoresizingMaskIntoConstraints = false
////        errorView.translatesAutoresizingMaskIntoConstraints = false
////        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
////        emptyView.translatesAutoresizingMaskIntoConstraints = false
////        
////        NSLayoutConstraint.activate([
////            emptyView.topAnchor.constraint(equalTo: registrationButton.bottomAnchor),
////            emptyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//////            emptyView.heightAnchor.constraint(greaterThanOrEqualToConstant: VSpacing.s.rawValue),
////        ])
////    }
////    
////    func makeConfiguredConstraints(viewModel: UserRegistrationViewModel) {
////        //NSLayoutConstraint.deactivate(emptyView.constraints)
////        let all = contentView.constraints.filter {
////            $0.firstItem === emptyView
////        }
////        NSLayoutConstraint.deactivate(all)
////        
////        if let imageLayout = viewModel.logoImage?.layout {
////            applyLayoutToView(layout: imageLayout.margin, view: logoImageView, topView: nil, botView: registrationTextLabel, superview: contentView)
////        }
////        
////        if let titleLayout = viewModel.titleLabel?.layout {
////            applyLayoutToView(layout: titleLayout.margin, view: registrationTextLabel, topView: logoImageView, botView: nameTextLabel, superview: contentView)
////        }
////        
////        if let nameLabelLayout = viewModel.nameLabel?.layout {
////            applyLayoutToView(layout: nameLabelLayout.margin, view: nameTextLabel, topView: registrationTextLabel, botView: nameTextField, superview: contentView)
////        }
////        
////        if let nameTextFieldLayout = viewModel.nameTextField?.layout {
////            applyLayoutToView(layout: nameTextFieldLayout.margin, view: nameTextField, topView: nameTextLabel, botView: phoneTextLabel, superview: contentView)
////        }
////        
////        if let phoneLabelLayout = viewModel.phoneLabel?.layout {
////            applyLayoutToView(layout: phoneLabelLayout.margin, view: phoneTextLabel, topView: nameTextField, botView: phoneTextLabel, superview: contentView)
////        }
////        
////        if let phoneTextFieldLayout = viewModel.phoneTextField?.layout {
////            applyLayoutToView(layout: phoneTextFieldLayout.margin, view: phoneTextField, topView: phoneTextLabel, botView: registrationButton, superview: contentView)
////        }
////        
////        if let buttonLayout = viewModel.button?.layout {
////            applyLayoutToView(layout: buttonLayout.margin, view: registrationButton, topView: phoneTextField, botView: emptyView, superview: contentView)
////        }
////        
////        if let activityLayout = viewModel.activityIndicator?.layout {
////            applyLayoutToView(layout: activityLayout.margin, view: activityIndicator, topView: self, botView: self, superview: contentView)
////        }
////        
////        if let mrg = viewModel.errorModel?.layout.margin {
////            applyLayoutToView(layout: mrg, view: errorView, topView: nil, botView: nil, superview: contentView)
////        }
////        
////        NSLayoutConstraint.activate([
////            emptyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
////        ])
////      
////    }
////    
//    
//    func setupKeyboardObservers() {
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillShow(_:)),
//                                               name: UIResponder.keyboardWillShowNotification,
//                                               object: nil)
//
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillHide(_:)),
//                                               name: UIResponder.keyboardWillHideNotification,
//                                               object: nil)
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//                        tapGesture.cancelsTouchesInView = false
//                        addGestureRecognizer(tapGesture)
//    }
//
//    @objc func keyboardWillShow(_ notification: Notification) {
//        guard let userInfo = notification.userInfo,
//              let kbFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
//              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
//
//        topConstraint?.isActive = false
//        bottomConstraint?.constant = -kbFrame.height
//        UIView.animate(withDuration: duration) {
//            self.layoutIfNeeded()
//        }
//    }
//
//    @objc func keyboardWillHide(_ notification: Notification) {
//        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
//
//        topConstraint?.isActive = true
//        bottomConstraint?.constant = 0
//        UIView.animate(withDuration: duration) {
//            self.layoutIfNeeded()
//        }
//    }
//    
//    @objc private func dismissKeyboard() {
//        endEditing(true)
//        topConstraint?.isActive = true
//        bottomConstraint?.constant = 0
//        UIView.animate(withDuration: 0.3) {
//            self.layoutIfNeeded()
//        }
//    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//}
