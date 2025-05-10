//
//  Created by Елизавета Кравченкова on 10/04/2025.
//

//import UIKit
//
//@MainActor
//protocol UserAutentificationViewProtocol : ViewProtocol {
//    func setup(with model: UserAutentificationViewModel)
//    func configure(with model: UserAutentificationViewModel)
//    func getInfo() -> UserAutentificationViewInfo
//}
//
//@MainActor
//class UserAutentificationView: UIView, UserAutentificationViewProtocol {
//    
//    override init(frame: CGRect = CGRect.zero) {
//        super.init(frame: frame)
//        
//        //addSubviews()
//        //makeConstraints()
//        setupKeyboardObservers()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    //var isUpdatingUI = false
//    
//    func setup(with model: UserAutentificationViewModel){
//        print("setup")
//        //isUpdatingUI = true
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
////
////        if (model.loginButton != nil) {
////            loginButton.configure(with: model.loginButton!)
////        }
////        if (model.errorModel != nil) {
////            errorView.configure(with: model.errorModel!)
////        }
////        if (model.phoneTextField != nil) {
////            phoneTextField.configure(with: model.phoneTextField!)
////        }
////        if (model.titleLabel != nil){
////            textLabel.configure(with: model.titleLabel!)
////        }
////        if (model.activityIndicator != nil){
////            activityIndicator.configure(with: model.activityIndicator!)
////        }
////        if (model.logoImage != nil){
////            logoImageView.configure(with: model.logoImage!)
////        }
////        makeConfiguredConstraints(viewModel: model)
//        //isUpdatingUI = false
//        
//    }
//    
//    
//    func configure(with model: UserAutentificationViewModel){
//        print("configure")
//        //isUpdatingUI = true
//        viewModel = model
//        
//        backgroundColor = model.style.backgroundColor
//        
//        let content = model.content
//        
//        guard contentView != nil else { return }
//        contentView!.configure(with: content)
//        
////        bottomConstraint = contentView!.bottomAnchor.constraint(equalTo: self.bottomAnchor)
////        topConstraint = contentView!.topAnchor.constraint(equalTo: self.topAnchor)
////        
////        NSLayoutConstraint.activate([
////            topConstraint!,
////            contentView!.trailingAnchor.constraint(equalTo: self.trailingAnchor),
////            contentView!.leadingAnchor.constraint(equalTo: self.leadingAnchor),
////            bottomConstraint!,
////            contentView!.widthAnchor.constraint(equalTo: self.widthAnchor),
////        ])
////
////        if (model.loginButton != nil) {
////            loginButton.configure(with: model.loginButton!)
////        }
////        if (model.errorModel != nil) {
////            errorView.configure(with: model.errorModel!)
////        }
////        if (model.phoneTextField != nil) {
////            phoneTextField.configure(with: model.phoneTextField!)
////        }
////        if (model.titleLabel != nil){
////            textLabel.configure(with: model.titleLabel!)
////        }
////        if (model.activityIndicator != nil){
////            activityIndicator.configure(with: model.activityIndicator!)
////        }
////        if (model.logoImage != nil){
////            logoImageView.configure(with: model.logoImage!)
////        }
////        makeConfiguredConstraints(viewModel: model)
//        //isUpdatingUI = false
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
////    private lazy var logoImageView  =  DSImage()
////    private lazy var activityIndicator = DSActivityIndicator()
////    private lazy var textLabel = DSLabel()
////    private lazy var loginButton = DSButton()
////    private lazy var phoneTextField = DSTextField()
////    private lazy var errorView = ErrorView()
////    private lazy var emptyView = UIView()
//    //private lazy var contentView =  UIView()
//    //private var contentView : DSView?
//    private var contentView : DSView?
// 
//    private var bottomConstraint: NSLayoutConstraint?
//    private var topConstraint: NSLayoutConstraint?
//    private var viewModel: UserAutentificationViewModel?
//    
//    func getInfo() -> UserAutentificationViewInfo{
//        let field = contentView?.findView(withAccessibilityIdentifier: "phoneTextField")
//        
//        guard field != nil else {
//            return .init(phoneTextField : .init(text: ""))
//        }
//        
//        guard let field = field as? DSTextField else {
//            return .init(phoneTextField : .init(text: ""))
//        }
//        
//        return .init(phoneTextField : field.getInfo())
//    }
//    
////    func addSubviews(){
////        self.addSubview(contentView)
////        
////        contentView.addSubview(logoImageView)
////        contentView.addSubview(textLabel)
////        contentView.addSubview(phoneTextField)
////        contentView.addSubview(loginButton)
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
////        
////        logoImageView.translatesAutoresizingMaskIntoConstraints = false
////        textLabel.translatesAutoresizingMaskIntoConstraints = false
////        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
////        loginButton.translatesAutoresizingMaskIntoConstraints = false
////        errorView.translatesAutoresizingMaskIntoConstraints = false
////        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
////        emptyView.translatesAutoresizingMaskIntoConstraints = false
////        
////        NSLayoutConstraint.activate([
////            emptyView.topAnchor.constraint(equalTo: loginButton.bottomAnchor),
////            emptyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//////            emptyView.heightAnchor.constraint(greaterThanOrEqualToConstant: VSpacing.s.rawValue),
////        ])
////    }
////    
////    func makeConfiguredConstraints(viewModel: UserAutentificationViewModel) {
////        //NSLayoutConstraint.deactivate(emptyView.constraints)
////        let all = contentView.constraints.filter {
////            $0.firstItem === emptyView
////        }
////        NSLayoutConstraint.deactivate(all)
////        
////        if let loginButtonLayout = viewModel.loginButton?.layout {
////            applyLayoutToView(layout: loginButtonLayout.margin, view: loginButton, topView: phoneTextField, botView: emptyView, superview: contentView)
////        }
////        if let labelLayout = viewModel.titleLabel?.layout {
////            applyLayoutToView(layout: labelLayout.margin, view: textLabel, topView: logoImageView, botView: phoneTextField, superview: contentView)
////        }
////        
////        if let textFieldLayout = viewModel.phoneTextField?.layout {
////            applyLayoutToView(layout: textFieldLayout.margin, view: phoneTextField, topView: textLabel, botView: loginButton, superview: contentView)
////        }
////        
////        if let activityLayout = viewModel.activityIndicator?.layout {
////            applyLayoutToView(layout: activityLayout.margin, view: activityIndicator, topView: self, botView: self, superview: contentView)
////        }
////        
////        if let imageLayout = viewModel.logoImage?.layout {
////            applyLayoutToView(layout: imageLayout.margin, view: logoImageView, topView: nil, botView: textLabel, superview: contentView)
////        }
////        
//////        if let imageLayout = viewModel.logoImage?.layout {
//////            applyLayoutToView(layout: imageLayout.margin, view: logoImageView, topView: nil, botView: self, superview: contentView)
//////        }
////        
////        if let mrg = viewModel.errorModel?.layout.margin {
////            applyLayoutToView(layout: mrg, view: errorView, topView: nil, botView: nil, superview: contentView)
////        }
////        
//////        if let mrg = viewModel.errorModel?.margin {
//////            applyLayoutToView(layout: mrg, view: errorView, topView: nil, botView: textLabel, superview: contentView)
//////        }
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
//        //if isUpdatingUI { return }
//        guard let userInfo = notification.userInfo,
//              let kbFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
//              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
//        print("keyboardWillShow")
//        topConstraint?.isActive = false
//        bottomConstraint?.constant = -kbFrame.height
//        UIView.animate(withDuration: duration) {
//            self.layoutIfNeeded()
//        }
//    }
//
//    @objc func keyboardWillHide(_ notification: Notification) {
//        //if isUpdatingUI { return }
//        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
//        
//        print("keyboardWillHide")
//        topConstraint?.isActive = true
//        bottomConstraint?.constant = 0
//        UIView.animate(withDuration: duration) {
//            self.layoutIfNeeded()
//        }
//    }
//    
//    @objc private func dismissKeyboard() {
//        //if isUpdatingUI { return }
//        print("dismissKeyboard")
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
