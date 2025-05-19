//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

@MainActor
protocol CommonViewProtocol {
    func configure(with model: CommonViewModel)
    func setup(with model: CommonViewModel)
}

@MainActor
class CommonView: UIView {

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let scrollView = UIScrollView()
    var contentView: DSView?
    
    private var viewModel: CommonViewModel?
    
    func setup(with model: CommonViewModel){
        viewModel = model
        
        backgroundColor = model.style.backgroundColor
        
        let content = model.content
        contentView = ComponentFactory.makeView(from: content)
        
        if (contentView == nil){
            return
        }

        contentView!.translatesAutoresizingMaskIntoConstraints = false

        scrollView.subviews.forEach { $0.removeFromSuperview() }
        
        scrollView.addSubview(contentView!)

        contentView!.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            contentView!.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView!.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView!.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView!.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView!.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    func configure(with model: CommonViewModel){
        viewModel = model
        
        backgroundColor = model.style.backgroundColor
        
        let content = model.content
        
        guard contentView != nil else { return }
        
        contentView!.configure(with: content)
    }
    
    
    func addSubviews(){
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

}
