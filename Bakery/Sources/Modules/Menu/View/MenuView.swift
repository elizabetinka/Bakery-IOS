//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

@MainActor
protocol MenuViewProtocol : ViewProtocol {
    func showLoading()
    func showError(message: String)
    
}

@MainActor
extension MenuView {
    @MainActor
    struct LocalAppearance {
        
        struct CollectionView {
            static let backgroundColor = UIColor.systemGray6
        }
        
        static func collectionViewApplyAppereance(view: UICollectionView){
            view.backgroundColor = CollectionView.backgroundColor
        }
    }
}

@MainActor
class MenuView: UIView {
 
    weak var refreshActionsDelegate: ErrorViewDelegate?
    weak var refreshControlDelegate: RefreshControlDelegate?

    init(frame: CGRect = CGRect.zero, refreshDelegate: ErrorViewDelegate, refreshControlDelegate: RefreshControlDelegate) {
        
        super.init(frame: frame)
        
        self.refreshActionsDelegate = refreshDelegate
        self.refreshControlDelegate = refreshControlDelegate
        
        addSubviews()
        makeConstraints()
        
        Appearance.mainViewApplyAppereance(view: self)
        
        collectionView.isHidden = true
        errorView.isHidden = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate(set) lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: makeTwoColumnLayout())
        view.register(CollectionCell<CardView>.self,
                      forCellWithReuseIdentifier: CollectionCell<CardView>.reuseIdentifier)
        view.refreshControl = refreshControl
        LocalAppearance.collectionViewApplyAppereance(view: view)
        return view
    }()
    
    lazy private var refreshControl = ViewFactory.getRefreshControl(delegate: refreshData)
    lazy private var activityIndicator : UIActivityIndicatorView = ViewFactory.getActivityIndicator()
    lazy private var errorView: ErrorView = ViewFactory.getErrorView(refreshDelegate: refreshActionsDelegate)

    func addSubviews(){
        self.addSubview(collectionView)
        self.addSubview(errorView)
        self.addSubview(activityIndicator)
    }

    func makeConstraints() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            errorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func makeTwoColumnLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .absolute(310))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 8, bottom: 8, trailing: 8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(310))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item, item])

        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopError() {
        activityIndicator.stopAnimating()
        errorView.isHidden = true
    }
    
    func showError(message: String) {
        activityIndicator.stopAnimating()
        errorView.configure(withMessage: message)
        errorView.isHidden = false
    }

    func updateTableViewData(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        activityIndicator.stopAnimating()
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.reloadData()
        collectionView.isHidden = false
    }
    
    @objc func refreshData() {
        refreshControlDelegate?.refreshData()
        refreshControl.endRefreshing()
    }
}
