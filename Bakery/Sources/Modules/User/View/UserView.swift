//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

@MainActor
protocol UserViewProtocol : ViewProtocol {
    func presentUserInfo(userInfo : UserInfoViewModel)
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
    weak var refreshActionsDelegate: ErrorViewDelegate?


    init(frame: CGRect = CGRect.zero, refreshDelegate: ErrorViewDelegate) {
        refreshActionsDelegate=refreshDelegate
        super.init(frame: frame)
        backgroundColor=LocalAppearance.backgroundColor
        addSubviews()
        makeConstraints()
        
        errorView.isHidden = true
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

    
    func presentUserInfo(userInfo : UserInfoViewModel){
        activityIndicator.stopAnimating()
        nameTextLabel.text = userInfo.name
        phoneTextLabel.text = userInfo.phoneNumber
        bonusCard.configure(value: String(userInfo.points))
        statusCard.configure(value: "Карта 3%")
    }
    
    lazy private var activityIndicator : UIActivityIndicatorView = ViewFactory.getActivityIndicator()
    lazy private var errorView: ErrorView = ViewFactory.getErrorView(refreshDelegate: refreshActionsDelegate)
    lazy private var scrollView = ViewFactory.getScrollView()
    lazy private var bonusCard = UserInfoCard(icon: LocalAppearance.bonusImage, titleText: "Бонусы")
    lazy private var statusCard = UserInfoCard(icon: LocalAppearance.statusImage, titleText: "Текущий статус")
    
    lazy private var nameTextLabel: UILabel = ViewFactory.getTitleLable(title: "Неизвестно", level: Appearance.TitleLabel.TitleFont.Level1)
    
    lazy private var phoneTextLabel: UILabel = ViewFactory.getTitleLable(title: "+0(000)000-00-00", level: Appearance.TitleLabel.TitleFont.Level2)
    
    lazy private var contentView: UIView = createContentView(nameTextLabel: nameTextLabel, phoneTextLabel: phoneTextLabel, bonusCard: bonusCard, statusCard: statusCard)
    
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
        scrollView.addSubview(activityIndicator)
    }

    func makeConstraints() {
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        errorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            activityIndicator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
    }
}
