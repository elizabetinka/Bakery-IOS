//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

extension MenuView {
    struct Appearance {
        let exampleOffset: CGFloat = 10
        let backgroundColor = UIColor.red
        let labelFont = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
}

class MenuView: UIView {
    let appearance = Appearance()
    
    weak var refreshActionsDelegate: ErrorViewDelegate?

    init(frame: CGRect = CGRect.zero, collectionDataSource: UICollectionViewDataSource,
                  collectionDelegate: UICollectionViewDelegate,refreshDelegate: ErrorViewDelegate) {
        
        super.init(frame: frame)
        
        configureCollectionView(collectionDataSource: collectionDataSource, collectionDelegate:collectionDelegate)
        refreshActionsDelegate = refreshDelegate
        
        backgroundColor=appearance.backgroundColor
        
        addSubviews()
        makeConstraints()
        
        collectionView.isHidden = true
        errorView.isHidden = true
    }
    
    private func configureCollectionView(collectionDataSource: UICollectionViewDataSource,
                                         collectionDelegate: UICollectionViewDelegate) {
        collectionView.dataSource = collectionDataSource
        collectionView.delegate = collectionDelegate
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    lazy private var activityIndicator : UIActivityIndicatorView = ViewFactory.getActivityIndicator()
    lazy private var errorView: ErrorView = ViewFactory.getErrorView(refreshDelegate: refreshActionsDelegate)
    lazy private var scrollView = ViewFactory.getScrollView()

    func addSubviews(){
        addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        scrollView.addSubview(collectionView)
        scrollView.addSubview(errorView)
        scrollView.addSubview(activityIndicator)
    }

    func makeConstraints() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorView.widthAnchor.constraint(equalToConstant: 300),
            errorView.heightAnchor.constraint(equalToConstant: 200),
            errorView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
    }
    
    
    func showLoading() {
        activityIndicator.startAnimating()
        show(view: collectionView)
    }

    func showError(message: String) {
        activityIndicator.stopAnimating()
        show(view: errorView)
        errorView.title.text = message
    }


    func show(view: UIView) {
        subviews.forEach { $0.isHidden = (view != $0) }
    }

    func updateTableViewData(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        show(view: collectionView)
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.reloadData()
    }
}
