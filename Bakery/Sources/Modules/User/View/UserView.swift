//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

@MainActor
protocol UserViewProtocol : ViewProtocol {
    func presentUserInfo(userInfo : UserInfoViewModel)
    func configure(with model: UserViewModel)
    func setup(with model: UserViewModel)
}

extension UserView {
    struct LocalAppearance {
        static let exampleOffset: CGFloat = 10
        static  let backgroundColor = UIColor.white
        static  let labelFont = UIFont.systemFont(ofSize: 17, weight: .medium)
        static  let bonusImage : UIImage = .points
        static  let statusImage : UIImage = .statistics
    }
}

@MainActor
class UserView: UIView, UserViewProtocol {
    //weak var refreshActionsDelegate: ErrorViewDelegate?
    private var viewModel: UserViewModel?

    override init(frame: CGRect = CGRect.zero) {
        //refreshActionsDelegate=refreshDelegate
        super.init(frame: frame)
        backgroundColor=LocalAppearance.backgroundColor
        //addSubviews()
        //makeConstraints()
        
        //errorView.isHidden = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoading() {
        //activityIndicator.startAnimating()
    }
    
    func stopError() {
//        errorView.isHidden = true
//        activityIndicator.stopAnimating()
    }
    
    func showError(message: String) {
//        activityIndicator.stopAnimating()
//        errorView.configure(withMessage: message)
//        errorView.isHidden = false
    }
    
    func setup(with model: UserViewModel){
        viewModel = model
        
        backgroundColor = model.style.backgroundColor
        
        let content = model.content
        contentView = ComponentFactory.makeView(from: content)
        
        if (contentView == nil){
            return
        }
        //print("after setup")
        //print("after content view frame \(String(describing: contentView?.frame))")
        contentView!.translatesAutoresizingMaskIntoConstraints = false

        self.subviews.forEach { $0.removeFromSuperview() }
        
        addSubview(contentView!)

        contentView!.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            contentView!.topAnchor.constraint(equalTo: self.topAnchor),
            contentView!.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView!.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView!.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentView!.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func configure(with model: UserViewModel){
        viewModel = model
        
        backgroundColor = model.style.backgroundColor
        
        let content = model.content
        
        guard contentView != nil else { return }
        
        contentView!.configure(with: content)
    }

    
    func presentUserInfo(userInfo : UserInfoViewModel){
//        activityIndicator.stopAnimating()
//        nameTextLabel.text = userInfo.name
//        phoneTextLabel.text = userInfo.phoneNumber
//        bonusCard.configure(value: String(userInfo.points))
//        statusCard.configure(value: "Карта 3%")
    }
    
    lazy private var activityIndicator = DSActivityIndicator()
    //lazy private var errorView = ErrorView()
    
//    : ErrorView = ViewFactory.getErrorView(refreshDelegate: refreshActionsDelegate)
    lazy private var scrollView = ViewFactory.getScrollView()
//    lazy private var bonusCard = UserInfoCard(icon: LocalAppearance.bonusImage, titleText: "Бонусы")
//    lazy private var statusCard = UserInfoCard(icon: LocalAppearance.statusImage, titleText: "Текущий статус")
    
//    private var statusCard:DSView?
//    private var bonusCard:DSView?
//    private lazy  var nameTextLabel = DSLabel()
//    private lazy var phoneTextLabel = DSLabel()
    
//    private lazy  var nameTextLabel: UILabel = ViewFactory.getTitleLable(title: "Неизвестно", level: Appearance.TitleLabel.TitleFont.Level1)
//    
//    private lazy var phoneTextLabel: UILabel = ViewFactory.getTitleLable(title: "+0(000)000-00-00", level: Appearance.TitleLabel.TitleFont.Level2)
    
    private var contentView: DSView?
    
    //createContentView(nameTextLabel: nameTextLabel, phoneTextLabel: phoneTextLabel, bonusCard: bonusCard, statusCard: statusCard)
    
//    func addSubviews(){
//        addSubview(scrollView)
//        
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
//        ])
//        
//        scrollView.addSubview(contentView)
//        scrollView.addSubview(errorView)
//        scrollView.addSubview(activityIndicator)
//    }
//
//    func makeConstraints() {
//        
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        errorView.translatesAutoresizingMaskIntoConstraints = false
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//           
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            
//
////            errorView.widthAnchor.constraint(equalToConstant: 300),
////            errorView.heightAnchor.constraint(equalToConstant: 200),
////            errorView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
////            errorView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
////            
////            activityIndicator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
////            activityIndicator.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
//        ])
//    }
//    
//    func makeConfiguredConstraints(viewModel: UserViewModel) {
//        
//        if let nameLabelLayout = viewModel.nameLabel?.layout {
//            applyLayoutToView(layout: nameLabelLayout.margin, view: nameTextLabel, topView: nil, botView: phoneTextLabel, superview: contentView)
//        }
//
//        if let phoneLabelLayout = viewModel.phoneLabel?.layout {
//            applyLayoutToView(layout: phoneLabelLayout.margin, view: phoneTextLabel, topView: nameTextLabel, botView: nil, superview: contentView)
//        }
//        
//        if let activityLayout = viewModel.activityIndicator?.layout {
//            applyLayoutToView(layout: activityLayout.margin, view: activityIndicator, topView: self, botView: self, superview: contentView)
//        }
//        
//        if let mrg = viewModel.errorModel?.layout.margin {
//            applyLayoutToView(layout: mrg, view: errorView, topView: nil, botView: nil, superview: contentView)
//        }
//      
//    }
}
