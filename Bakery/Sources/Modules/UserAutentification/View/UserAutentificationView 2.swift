//
//  Created by Елизавета Кравченкова on 10/04/2025.
//

//import UIKit
//
//@MainActor
//protocol UserAutentificationViewProtocol2 : ViewProtocol {
//    func configure(with model: UserAutentificationViewModel)
//    func getInfo() -> UserAutentificationViewInfo
//}
//
//@MainActor
//class UserAutentificationView2: UIView, UserAutentificationViewProtocol {
//    
//    override init(frame: CGRect = CGRect.zero) {
//        
//        super.init(frame: frame)
//        addSubviews()
//        makeConstraints()
//        
//        setupKeyboardObservers()
//        
//        //Appearance.mainViewApplyAppereance(view: self)
//        //errorView.isHidden = true
//        
//        
//        //print(UIScreen.main.bounds)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configure(with model: UserAutentificationViewModel){
//        viewModel = model
//        
//        backgroundColor = model.style.backgroundColor
//        
//        if (model.loginButton != nil) {
//            loginButton.configure(with: model.loginButton!)
//        }
//        if (model.errorModel != nil) {
//            errorView.configure(with: model.errorModel!)
//        }
//        if (model.phoneTextField != nil) {
//            phoneTextField.configure(with: model.phoneTextField!)
//        }
//        if (model.titleLabel != nil){
//            textLabel.configure(with: model.titleLabel!)
//        }
//        if (model.activityIndicator != nil){
//            activityIndicator.configure(with: model.activityIndicator!)
//        }
//        if (model.logoImage != nil){
//            logoImageView.configure(with: model.logoImage!)
//        }
//        makeConfiguredConstraints(viewModel: model)
//        
//    }
//    
//    func showLoading() {
//    }
//    
//    func stopError() {
//    }
//    
//    func showError(message: String) {
//    }
//
//    private lazy var logoImageView  =  DSImage()
//    private lazy var activityIndicator = DSActivityIndicator()
//    private lazy var textLabel = DSLabel()
//    private lazy var loginButton = DSButton()
//    private lazy var phoneTextField = DSTextField()
//    private lazy var errorView = ErrorView()
//    private lazy var emptyView = UIView()
//    private lazy var contentView =  UIView()
//    
//    
////    private lazy var contentView: UIView = createContentView(textLabel: textLabel, phoneTextField: phoneTextField, loginButton: loginButton, image: logoImageView, errorView: errorView, activityIndicator: activityIndicator)
//    
//    private var bottomConstraint: NSLayoutConstraint?
//    private var topConstraint: NSLayoutConstraint?
//    private var viewModel: UserAutentificationViewModel?
//    
//    func getInfo() -> UserAutentificationViewInfo{
//        return .init(phoneTextField : phoneTextField.getInfo())
//    }
//    
//    
//    func addSubviews(){
//        self.addSubview(contentView)
//        
//        contentView.addSubview(logoImageView)
//        contentView.addSubview(textLabel)
//        contentView.addSubview(phoneTextField)
//        contentView.addSubview(loginButton)
//        contentView.addSubview(emptyView)
//        contentView.addSubview(errorView)
//        contentView.addSubview(activityIndicator)
//    }
//
//    func makeConstraints() {
//        
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//
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
//        
//        logoImageView.translatesAutoresizingMaskIntoConstraints = false
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
//        loginButton.translatesAutoresizingMaskIntoConstraints = false
//        errorView.translatesAutoresizingMaskIntoConstraints = false
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        emptyView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
////            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
////            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: VSpacing.l.rawValue),
//            
////            textLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: VSpacing.xxl),
////            textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
////            //textLabel.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -HSpacing.m),
////            textLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: HSpacing.m),
////            textLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -HSpacing.m),
//            
////            phoneTextField.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: VSpacing.l),
////            //phoneTextField.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
////            phoneTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -HSpacing.m),
////            phoneTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: HSpacing.m),
//            //phoneTextField.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
//            //phoneTextField.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
//            
//            //loginButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: VSpacing.m),
//            //loginButton.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -HSpacing.m),
//            //loginButton.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: HSpacing.m),
//            //loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            //loginButton.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: HSpacing.m),
//            //loginButton.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -HSpacing.m),
//            
////            errorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
////            errorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            
//            emptyView.topAnchor.constraint(equalTo: loginButton.bottomAnchor),
//            emptyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            emptyView.heightAnchor.constraint(greaterThanOrEqualToConstant: VSpacing.s.rawValue),
//            
////            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
////            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//        ])
//    }
//    
//    func makeConfiguredConstraints(viewModel: UserAutentificationViewModel) {
//        
////        if (viewModel.loginButton)
////        let all = contentView.constraints.filter {
////            $0.firstItem === loginButton || $0.firstItem === textLabel
////        }
////        NSLayoutConstraint.deactivate(all)
//        
//        //NSLayoutConstraint.deactivate(contentView.constraints)
//        
//        if let loginButtonLayout = viewModel.loginButton?.layout {
//            applyLayoutToView(layout: loginButtonLayout.margin, view: loginButton, topView: phoneTextField, botView: contentView, superview: contentView)
//        }
//        if let labelLayout = viewModel.titleLabel?.layout {
//            applyLayoutToView(layout: labelLayout.margin, view: textLabel, topView: logoImageView, botView: phoneTextField, superview: contentView)
//        }
//        
//        //print("viewModel.phoneTextField \(phoneTextField.frame)")
//        
//        if let textFieldLayout = viewModel.phoneTextField?.layout {
//            applyLayoutToView(layout: textFieldLayout.margin, view: phoneTextField, topView: textLabel, botView: loginButton, superview: contentView)
//        }
//        
//        if let activityLayout = viewModel.activityIndicator?.layout {
//            applyLayoutToView(layout: activityLayout.margin, view: activityIndicator, topView: self, botView: self, superview: contentView)
//        }
//        
//        if let imageLayout = viewModel.logoImage?.layout {
//            applyLayoutToView(layout: imageLayout.margin, view: logoImageView, topView: nil, botView: self, superview: contentView)
//        }
//        
//        if let mrg = viewModel.errorModel?.margin {
//            applyLayoutToView(layout: mrg, view: errorView, topView: nil, botView: textLabel, superview: contentView)
//        }
//        
//        
//        
////        if loginButtonLayout?.width == .fill,  let mrg = loginButtonLayout?.hMargin {
////            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: mrg).isActive = true
////            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -mrg).isActive = true
////        }
////        if loginButtonLayout?.hAlign == .center {
////            loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
////        }
////        if loginButtonLayout?.vAlign == .center {
////            loginButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
////        }
////        if let mrg = loginButtonLayout?.topMargin {
////            loginButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: mrg).isActive = true
////        }
////        if let mrg = loginButtonLayout?.bottomMargin {
////            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -mrg).isActive = true
////        }
//        
//        
//        
////        let labelLayout = viewModel.titleLabel?.layout
////        
////        if labelLayout?.width == .fill,  let mrg = labelLayout?.hMargin {
////            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: mrg).isActive = true
////            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -mrg).isActive = true
////        }
////        if labelLayout?.hAlign == .center {
////            textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
////        }
////        if labelLayout?.vAlign == .center {
////            textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
////        }
////        if let mrg = labelLayout?.topMargin {
////            textLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: mrg).isActive = true
////        }
////        if let mrg = labelLayout?.bottomMargin {
////            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -mrg).isActive = true
////        }
//        
//        //self.contentView.layoutIfNeeded()
//    }
//    
////    func applyLayoutToView(layout: DSLayout, view: UIView, topView: UIView, botView: UIView){
////        let all = contentView.constraints.filter {
////            $0.firstItem === view
////        }
////        NSLayoutConstraint.deactivate(all)
////        
////        if layout.width == .fill,  let mrg = layout.hMargin {
////            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: mrg).isActive = true
////            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -mrg).isActive = true
////        }
////        if layout.hAlign == .center {
////            view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
////        }
////        if layout.vAlign == .center {
////            view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
////        }
////        if let mrg = layout.topMargin {
////            view.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: mrg).isActive = true
////        }
////        if let mrg = layout.bottomMargin {
////            view.bottomAnchor.constraint(equalTo: botView.bottomAnchor, constant: -mrg).isActive = true
////        }
////        
////        self.contentView.layoutIfNeeded()
////    }
//    
//    
//    func setupKeyboardObservers() {
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillShow),
//                                               name: UIResponder.keyboardWillShowNotification,
//                                               object: nil)
//
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillHide),
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
//
//
