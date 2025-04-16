//
//  menu logic
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

protocol MenuDisplayLogic: AnyObject {
    func displayItems(viewModel: Menu.ShowItems.ViewModel)
}

protocol MenuRouterAppearance: AnyObject {
    func applyRouterSettigs()
}

protocol MenuViewControllerDelegate: AnyObject {
    func openItemDetails(_ itemId: UniqueIdentifier)
}

class MenuViewController: UIViewController {
    let interactor: MenuBusinessLogic
    var state: Menu.ViewControllerState
    weak var router: TabBarRouterProtocol?
    lazy var customView = self.view as? MenuView
    
    var collectionDataSource: MenuCollectionDataSource = MenuCollectionDataSource()
    var collectionHandler: MenuCollectionDelegate = MenuCollectionDelegate()

    init(interactor: MenuBusinessLogic, initialState: Menu.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        
        super.init(nibName: nil, bundle: nil)
        
        collectionHandler.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func loadView() {
        let view = MenuView(frame: UIScreen.main.bounds, collectionDataSource: collectionDataSource, collectionDelegate: collectionHandler, refreshDelegate: self)
        self.view = view
        // make additional setup of view or save references to subviews
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("MenuViewController: viewDidLoad")
        display(newState: state)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.bounds = view.safeAreaLayoutGuide.layoutFrame
    }
    
    // MARK: Do something
    func fetchItems() {
            let request = Menu.ShowItems.Request()
            interactor.fetchItems(request: request)
        }
}

extension MenuViewController: MenuDisplayLogic {
    func displayItems(viewModel: Menu.ShowItems.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: Menu.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            customView?.showLoading()
            fetchItems()
        case let .error(message):
            customView?.showError(message: message)
        case let .result(items):
            collectionHandler.representableViewModel = items
            collectionDataSource.representableViewModel = items
            customView?.updateTableViewData(delegate: collectionHandler, dataSource: collectionDataSource)
        case .emptyResult:
            collectionHandler.representableViewModel = []
            collectionDataSource.representableViewModel = []
            customView?.updateTableViewData(delegate: collectionHandler, dataSource: collectionDataSource)
        }
    }
}

extension MenuViewController : MenuRouterAppearance {
    
    func applyRouterSettigs() {
        let tabBarSetting  = TabBarSetting()
        tabBarItem = UITabBarItem(
            title: tabBarSetting.tabBarTitle,
            image: tabBarSetting.image,
            selectedImage: tabBarSetting.selectedImage)
    }
    
    struct TabBarSetting {
        let tabBarTitle = String("меню")
        let image = UIImage(systemName: "birthday.cake")
        let selectedImage = UIImage(systemName: "birthday.cake.fill")
    }
    
}


extension MenuViewController: MenuViewControllerDelegate {
    func openItemDetails(_ itemId: UniqueIdentifier) {
        router?.openViewController(toView: MyViewController.itemDetails(itemId: itemId))
    }
}


extension MenuViewController: ErrorViewDelegate {
    func reloadButtonWasTapped() {
        display(newState: .loading)
    }
}
