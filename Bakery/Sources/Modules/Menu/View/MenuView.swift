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

    
    fileprivate(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    
    lazy var errorView: CommonErrorView = {
            let view = CommonErrorView()
            view.delegate = self.refreshActionsDelegate
            return view
        }()
    
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

    func addSubviews(){
        addSubview(collectionView)
        addSubview(errorView)
    }

    func makeConstraints() {
    }
    
    
    func showLoading() {
        show(view: collectionView)
    }

    func showError(message: String) {
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
