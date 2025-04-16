//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

extension CommonView {
    struct Appearance {
        let exampleOffset: CGFloat = 10
        let backgroundColor = UIColor.systemGray
        let labelFont = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
    
}

class CommonView: UIView {
    let appearance = Appearance()

//    fileprivate(set) lazy var customView: UIView = {
//        let view = UIView()
//        return view
//    }()
    
    fileprivate(set) lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        return view
    }()
    
    lazy var errorView: CommonErrorView = {
            let view = CommonErrorView()
            view.delegate = self.refreshActionsDelegate
            return view
        }()

    weak var refreshActionsDelegate: ErrorViewDelegate?
    
//    private lazy var tableBackgroundView: UIView = UIView()
//    
//    fileprivate(set) lazy var userInfoView: UIView = {
//        let view = UIView()
//        return view
//    }()


    init(frame: CGRect = CGRect.zero, tableDataSource: UITableViewDataSource,
                  tableDelegate: UITableViewDelegate,refreshDelegate: ErrorViewDelegate) {
        super.init(frame: frame)
        
        configureTableView(tableDataSource: tableDataSource, tableDelegate:tableDelegate)
        refreshActionsDelegate = refreshDelegate
        backgroundColor=appearance.backgroundColor
        addSubviews()
        makeConstraints()
        
        
        tableView.isHidden = true
        errorView.isHidden = true
    }
    
    // MARK: - Private Methods
    private func configureTableView(tableDataSource: UITableViewDataSource,
                                    tableDelegate: UITableViewDelegate) {
        tableView.dataSource = tableDataSource
        tableView.delegate = tableDelegate
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews(){
        addSubview(tableView)
        addSubview(errorView)
    }

    func makeConstraints() {
    }
    

    func showUserLoading() {
        show(view: tableView)
    }
    
    func showItemLoading() {
        show(view: tableView)
    }

    func showError(message: String) {
        show(view: errorView)
        errorView.title.text = message
    }


    func show(view: UIView) {
        subviews.forEach { $0.isHidden = (view != $0) }
    }

    func updateTableViewData(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        show(view: tableView)
        tableView.tableFooterView = nil
        tableView.tableHeaderView = nil
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.reloadData()
    }
}
