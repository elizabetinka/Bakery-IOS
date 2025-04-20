//
//  Отвечает за логику главного экрана
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

protocol CommonDisplayLogic: AnyObject {
    func displayUserInfo(viewModel: Common.ShowUserInfo.ViewModel)
    func displayItem(viewModel: Common.ShowItem.ViewModel)
}

protocol CommonRouterAppearance: AnyObject {
    func applyRouterSettigs()
}

protocol CommonViewControllerDelegate: AnyObject {
    func openMenu()
    func openUser()
}

class CommonViewController: UIViewController {
    let interactor: CommonBusinessLogic

    var userState: Common.ShowUserInfo.ViewControllerState
    var itemState: Common.ShowItem.ViewControllerState
    weak var router: TabBarRouterProtocol?
    
    private let commonTableDataSource: CommonTableDataSource = CommonTableDataSource()
    private let commonTableDelegate: CommonTableDelegate = CommonTableDelegate()
    
    lazy var customView = self.view as? CommonView
        

    init(interactor: CommonBusinessLogic,  userInitialState: Common.ShowUserInfo.ViewControllerState = .loading, itemInitialState: Common.ShowItem.ViewControllerState = .loading) {
        self.interactor = interactor

        self.userState = userInitialState
        self.itemState = itemInitialState
        super.init(nibName: nil, bundle: nil)
        
        commonTableDelegate.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func loadView() {
        let view = CommonView(frame: UIScreen.main.bounds, tableDataSource: commonTableDataSource, tableDelegate: commonTableDelegate, refreshDelegate: self)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("CommonViewController: viewDidLoad")
        display(newState: userState)
        display(newState: itemState)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.bounds = view.safeAreaLayoutGuide.layoutFrame
    }

    // MARK: Do something
    func showUserInfo() async{
        let request = Common.ShowUserInfo.Request()
        await interactor.showUserInfo(request: request)
    }
    
    func showItem() async {
        let request = Common.ShowItem.Request()
        await interactor.showItem(request: request)
    }
}

extension CommonViewController: CommonDisplayLogic {
    func displayUserInfo(viewModel: Common.ShowUserInfo.ViewModel) {
        display(newState: viewModel.state)
    }
    
    func displayItem(viewModel: Common.ShowItem.ViewModel) {
        display(newState: viewModel.state)
    }
    
    func display(newState: Common.ShowUserInfo.ViewControllerState) {
        userState = newState
        switch userState {
        case .loading:
            customView?.showUserLoading()
            Task {
                await showUserInfo()
            }
        case let .error(message):
            customView?.showError(message: message)
        case let .authorizedResult(viewModel):
            commonTableDataSource.setUserModel(viewModel)
        case .notAuthorized:
            commonTableDataSource.setUserModel(nil)
            customView?.updateTableViewData(delegate: commonTableDelegate, dataSource: commonTableDataSource)
        }
    }
    
    func display(newState: Common.ShowItem.ViewControllerState) {
        itemState = newState
        switch itemState {
        case .loading:
            customView?.showItemLoading()
            Task {
                await showItem()
            }
        case let .error(message):
            customView?.showError(message: message)
        case let .result(viewModel):
            commonTableDataSource.setItemModel(viewModel)
            customView?.updateTableViewData(delegate: commonTableDelegate, dataSource: commonTableDataSource)
        case .emptyResult:
            commonTableDataSource.setItemModel(nil)
            customView?.updateTableViewData(delegate: commonTableDelegate, dataSource: commonTableDataSource)
        }
    }
}

extension CommonViewController : CommonRouterAppearance {
    
    func applyRouterSettigs() {
        let tabBarSetting  = TabBarSetting()
        tabBarItem = UITabBarItem(
            title: tabBarSetting.tabBarTitle,
            image: tabBarSetting.image,
            selectedImage: tabBarSetting.selectedImage)
        title = tabBarSetting.title
    }
    
    struct TabBarSetting {
        let tabBarTitle = String("главная")
        let image = UIImage(systemName: "house")
        let selectedImage = UIImage(systemName: "house.fill")
        let title = "главная"
    }
    
}

extension CommonViewController: CommonViewControllerDelegate {
    func openMenu() {
        router?.openViewController(toView: MyViewController.menu)
    }
    
    func openUser() {
        router?.openViewController(toView: MyViewController.user)
    }
}

extension CommonViewController: ErrorViewDelegate {
    func reloadButtonWasTapped() {
        userState = .loading
        itemState = .loading
        display(newState: userState)
        display(newState: itemState)
    }
}

