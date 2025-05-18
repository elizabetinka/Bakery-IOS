//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

@MainActor
protocol UserViewProtocol {
    func configure(with model: UserViewModel)
    func setup(with model: UserViewModel)
}

@MainActor
class UserView: UIView, UserViewProtocol {
    private var viewModel: UserViewModel?
    private var contentView: DSView?

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with model: UserViewModel){
        viewModel = model
        
        backgroundColor = model.style.backgroundColor
        
        let content = model.content
        contentView = ComponentFactory.makeView(from: content)
        
        if (contentView == nil){
            return
        }

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
}
