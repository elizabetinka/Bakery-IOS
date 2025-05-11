//
//  Отвечает за логику главного экрана
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

protocol CommonDisplayLogic: AnyObject {
    func displayUserInfo(viewModel: Common.ShowUserInfo.ViewModel)
    func displayItem(viewModel: Common.ShowItem.ViewModel)
    func displayAction(viewModel: Common.ShowAction.ViewModel)
    
    func displaySomething(viewModel: Common.LoadingUserInfo.ViewModel)
    func displaySomething(viewModel: Common.LoadingItem.ViewModel)
    func displaySomething(viewModel: Common.LoadingAction.ViewModel)

}

protocol CommonRouterAppearance: AnyObject {
    func applyRouterSettigs()
}

protocol CardsDelegate: AnyObject {
    func didTapUserCard()
    func didTapItemCard()
    func didTapActionCard()
}

//protocol CommonViewControllerDelegate: AnyObject {
//    func openMenu()
//    func openUser()
//}

class CommonViewController: UIViewController {
    let interactor: CommonBusinessLogic

    var state: Common.ViewControllerState
    weak var router: TabBarRouterProtocol?
    
//    private let commonTableDataSource: CommonTableDataSource = CommonTableDataSource()
//    private let commonTableDelegate: CommonTableDelegate = CommonTableDelegate()
    
    lazy var customView = self.view as? CommonView
        

    init(interactor: CommonBusinessLogic, state: Common.ViewControllerState = .initial) {
        self.interactor = interactor
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func loadView() {
        let view = CommonView()
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("CommonViewController: viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("CommonViewController viewWillAppear")
        display(newState: .initial)
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        //view.bounds = view.safeAreaLayoutGuide.layoutFrame
//    }

    func loadingUserInfo(){
        let request = Common.LoadingUserInfo.Request()
        interactor.loadingUserInfo(request: request)
    }
    
    func loadingItem() {
        let request = Common.LoadingItem.Request()
        interactor.loadingItem(request: request)
    }
    
    func loadingAction() {
        let request = Common.LoadingAction.Request()
        interactor.loadingAction(request: request)
    }
    
    // MARK: Do something
    func showUserInfo() async{
        loadingUserInfo()
        let request = Common.ShowUserInfo.Request()
        await interactor.showUserInfo(request: request)
    }
    
    func showItem() async {
        loadingItem()
        let request = Common.ShowItem.Request()
        await interactor.showItem(request: request)
    }
    
    func showAction() async {
        loadingAction()
        let request = Common.ShowAction.Request()
        await interactor.showAction(request: request)
    }
}

extension CommonViewController: CommonDisplayLogic {

    func displayUserInfo(viewModel: Common.ShowUserInfo.ViewModel) {
        display(newState: viewModel.state)
    }
    
    func displayItem(viewModel: Common.ShowItem.ViewModel) {
        display(newState: viewModel.state)
    }
    func displayAction(viewModel: Common.ShowAction.ViewModel) {
        display(newState: viewModel.state)
    }
    
    func displaySomething(viewModel: Common.LoadingUserInfo.ViewModel) {
        display(newState: viewModel.state)
    }
    func displaySomething(viewModel: Common.LoadingItem.ViewModel) {
        display(newState: viewModel.state)
    }
    func displaySomething(viewModel: Common.LoadingAction.ViewModel) {
        display(newState: viewModel.state)
    }
    
    func display(newState: Common.ViewControllerState) {
        state = newState
        switch state {
        case .initial:
            Task {
                await showUserInfo()
            }
            Task {
                await showItem()
            }
            Task {
                await showAction()
            }
        case let .setup(model):
            customView?.setup(with: model)
        case let .configure(model):
            customView?.configure(with: model)
            //        case .notAuthorized:
            //            commonTableDataSource.setUserModel(nil)
            //            customView?.updateTableViewData(delegate: commonTableDelegate, dataSource: commonTableDataSource)
            //        }
        }}
    
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

//extension CommonViewController: CommonViewControllerDelegate {
//    func openMenu() {
//        router?.openViewController(toView: MyViewController.menu)
//    }
//    
//    func openUser() {
//        router?.openViewController(toView: MyViewController.user)
//    }
//}
//
//extension CommonViewController: ErrorViewDelegate {
//    func reloadButtonWasTapped() {
//        state = .initial
//        display(newState: state)
//    }
//}


extension CommonViewController : CardsDelegate {
    func didTapUserCard() {
        router?.openViewController(toView: MyViewController.user)
    }
    
    func didTapItemCard() {
        router?.openViewController(toView: MyViewController.menu)
    }
    
    func didTapActionCard() {
        router?.openViewController(toView: MyViewController.menu)
    }
}
