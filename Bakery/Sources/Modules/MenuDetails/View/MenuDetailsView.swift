//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

@MainActor
extension MenuDetailsView {
    @MainActor
    struct LocalAppearance {    
        struct TitleLabel {
            static let  textAlignment =  NSTextAlignment.left
        }
        
        static func textLabelApplyAppereance(textLabel: UILabel) {
            textLabel.textAlignment = LocalAppearance.TitleLabel.textAlignment
        }
    }
}

@MainActor
class MenuDetailsView: UIView {
    
    weak var refreshActionsDelegate: ErrorViewDelegate?

    init(frame: CGRect = CGRect.zero, refreshDelegate: ErrorViewDelegate) {
        self.refreshActionsDelegate = refreshDelegate
        
        super.init(frame: frame)
        
        Appearance.mainViewApplyAppereance(view: self)
        
        addSubviews()
        makeConstraints()
        
        errorView.isHidden = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var errorView: ErrorView = ViewFactory.getErrorView(refreshDelegate: refreshActionsDelegate)
    lazy private var activityIndicator : UIActivityIndicatorView = ViewFactory.getActivityIndicator()
    lazy private var activityImageIndicator : UIActivityIndicatorView = ViewFactory.getActivityIndicator()
    lazy private var scrollView = ViewFactory.getScrollView()
    
    lazy private var imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.clipsToBounds = true
            return iv
        }()
    
    lazy private var titleLabel: UILabel = {
        let ans = ViewFactory.getTitleLable(title: "", level: Appearance.TitleLabel.TitleFont.Level1)
        LocalAppearance.textLabelApplyAppereance(textLabel: ans)
        return ans
    }()

    lazy private var descriptionLabel: UILabel = {
        let ans = ViewFactory.getTitleLable(title: "", level: Appearance.TitleLabel.TitleFont.Level2)
        LocalAppearance.textLabelApplyAppereance(textLabel: ans)
        return ans
    }()
    
    lazy private var contentView: UIView = createContentView(imageView: imageView, titleLabel: titleLabel, descriptionLabel: descriptionLabel)

    func addSubviews(){
        addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        scrollView.addSubview(contentView)
        scrollView.addSubview(errorView)
        scrollView.addSubview(activityIndicator)
        scrollView.addSubview(activityImageIndicator)
    }

    func makeConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityImageIndicator.translatesAutoresizingMaskIntoConstraints = false
        errorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            
            activityImageIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityImageIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            errorView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            
        ])
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopError() {
        activityIndicator.stopAnimating()
        activityImageIndicator.stopAnimating()
        errorView.isHidden = true
    }
    
    func showError(message: String) {
        activityIndicator.stopAnimating()
        activityImageIndicator.stopAnimating()
        errorView.configure(withMessage: message)
        errorView.isHidden = false
    }
    
    func updateData(details: MenuDetailsViewModel) {
        activityIndicator.stopAnimating()
        imageView.image = details.itemImage
        titleLabel.text = details.name
        descriptionLabel.text = "\(details.description) \n\n Калории на 100г: \(details.kcal) ккал \n\n Стоимость \(details.cost) р"
        
        if details.itemImage == nil {
            activityImageIndicator.startAnimating()
        }
        else{
            activityImageIndicator.stopAnimating()
        }
    }
    
    func showEmptyView(){}
}
