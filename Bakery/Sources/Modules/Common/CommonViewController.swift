//
//  Отвечает за логику главного экрана
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

protocol CommonDisplayLogic: AnyObject {
    func displayModule(viewModel: Common.ShowModule.ViewModel)
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
    var state: Common.ViewControllerState
    weak var router: TabBarRouterProtocol?
    
    private let commonTableDataSource: CommonTableDataSource = CommonTableDataSource()
    private let commonTableDelegate: CommonTableDelegate = CommonTableDelegate()
    
    lazy var customView = self.view as? CommonView
        

    init(interactor: CommonBusinessLogic, initialState: Common.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
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
        // make additional setup of view or save references to subviews
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showModule()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("View frame: \(view.frame)")
        view.bounds = view.safeAreaLayoutGuide.layoutFrame
        print("View frame2: \(view.frame)")
    }

    // MARK: Do something
    func showModule() {
        let request = Common.ShowModule.Request()
        interactor.getInformation(request: request)
    }
    

}

extension CommonViewController: CommonDisplayLogic {
    func displayModule(viewModel: Common.ShowModule.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: Common.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            print("loading...")
            customView?.showLoading()
            showModule()
        case let .error(message):
            print("error \(message)")
            customView?.showError(message: message)
        case let .authorizedResult(viewModel):
            print("authorizedResult")
            commonTableDelegate.representableViewModel = viewModel
            commonTableDataSource.representableViewModel = viewModel
            customView?.updateTableViewData(delegate: commonTableDelegate, dataSource: commonTableDataSource)
        case let .notAuthorizedResult(viewModel):
            print("not authorizedResult")
            commonTableDelegate.representableViewModel = viewModel
            commonTableDataSource.representableViewModel = viewModel
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
    }
    
    struct TabBarSetting {
        let tabBarTitle = String("главная")
        let image = UIImage(systemName: "house")
        let selectedImage = UIImage(systemName: "house.fill")
    }
    
}


extension CommonViewController: CommonViewControllerDelegate {
    func openMenu() {
        router?.openViewController(myView: MyViewController.menu)
    }
    
    func openUser() {
        router?.openViewController(myView: MyViewController.user)
    }
}

extension CommonViewController: ErrorViewDelegate {
    func reloadButtonWasTapped() {
        display(newState: .loading)
    }
}

//
//extension CommonViewController : CommonRouterLogic {
//    
//    func applyTabBarSettigs() {
//        let tabBarSetting  = TabBarSetting()
//        tabBarItem = UITabBarItem(
//            title: tabBarSetting.tabBarTitle,
//            image: tabBarSetting.image,
//            selectedImage: tabBarSetting.selectedImage)
//    }
//    
//    struct TabBarSetting {
//        let tabBarTitle = String("профиль")
//        let image = UIImage(systemName: "person")
//        let selectedImage = UIImage(systemName: "person.fill")
//    }
//}

