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

class MenuViewController: UIViewController {
    let interactor: MenuBusinessLogic
    var state: Menu.ViewControllerState
    weak var router: TabBarRouterProtocol?
    lazy var customView = self.view as? MenuView
    
    private var tableManager : TableManagerProtocol

    init(interactor: MenuBusinessLogic, initialState: Menu.ViewControllerState = .loading, tableManager: TableManagerProtocol = TableManager()) {
        self.interactor = interactor
        self.state = initialState
        self.tableManager = tableManager
        
        super.init(nibName: nil, bundle: nil)
        
        self.tableManager.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func loadView() {
        let view = MenuView(frame: UIScreen.main.bounds, refreshDelegate: self, refreshControlDelegate: self)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("MenuViewController: viewDidLoad")
        display(newState: state)
    }
    
    // MARK: Do something
    func fetchItems() async {
            let request = Menu.ShowItems.Request()
            await interactor.fetchItems(request: request)
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
            Task{
                await fetchItems()
            }
        case let .error(message):
            customView?.showError(message: message)
        case let .result(items):
            tableManager.updateData(with: items)
        case .emptyResult:
            tableManager.updateData(with: [])
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
        title = tabBarSetting.title
    }
    
    struct TabBarSetting {
        let tabBarTitle = String("меню")
        let image = UIImage(systemName: "birthday.cake")
        let selectedImage = UIImage(systemName: "birthday.cake.fill")
        let title = "меню"
    }
    
}

extension MenuViewController: TableManagerDelegate {
    func didUpdateData() {
        customView?.updateTableViewData(delegate: tableManager, dataSource: tableManager)
    }
    
    func openItemTapped(_ itemId: UniqueIdentifier) {
        router?.openViewController(toView: MyViewController.itemDetails(itemId: itemId))
    }
}


extension MenuViewController: ErrorViewDelegate {
    func reloadButtonWasTapped() {
        display(newState: .loading)
    }
}


extension MenuViewController: RefreshControlDelegate {
    func refreshData() {
        display(newState: .loading)
    }
}
