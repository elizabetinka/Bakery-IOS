//
//  item details
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

protocol MenuDetailsDisplayLogic: AnyObject {
    func presentItemDetails(viewModel: MenuDetails.ShowDetails.ViewModel)
}

protocol MenuDetailsRouterAppearance: AnyObject {
    func applyRouterSettigs()
}

class MenuDetailsViewController: UIViewController {
    let interactor: MenuDetailsBusinessLogic
    var state: MenuDetails.ViewControllerState
    
    private lazy var customView = self.view as? MenuDetailsView

    init(interactor: MenuDetailsBusinessLogic, initialState: MenuDetails.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func loadView() {
        let view = MenuDetailsView(frame: UIScreen.main.bounds)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("MenuDetailsViewController.viewDidLoad")
        display(newState: state)
    }

    // MARK: Do something
    func fetchItemDetails(withId uuid: UniqueIdentifier) async {
        let request = MenuDetails.ShowDetails.Request(itemId: uuid)
        await interactor.fetchItemDetails(request: request)
    }
}

extension MenuDetailsViewController: MenuDetailsDisplayLogic {
    func presentItemDetails(viewModel: MenuDetails.ShowDetails.ViewModel) {
        display(newState: viewModel.state)
    }
    
    func display(newState: MenuDetails.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            print("loading...")
            customView?.showLoading()
        case let .error(message):
            print("error \(message)")
            customView?.showError(message: message)
        case let .result(menuDetails):
            print("result: \(menuDetails)")
            customView?.updateData(details: menuDetails)
        case .emptyResult:
            print("empty result")
            customView?.showEmptyView()
        case .initial(id: let id):
            customView?.showLoading()
            Task{
                await fetchItemDetails(withId: id)
            }
        }
    }
}

extension MenuDetailsViewController : MenuDetailsRouterAppearance {
    
    func applyRouterSettigs() {
        let tabBarSetting  = TabBarSetting()
        
        if let sheet = sheetPresentationController {
            sheet.detents = tabBarSetting.detents
            sheet.prefersGrabberVisible = tabBarSetting.prefersGrabberVisible
            sheet.preferredCornerRadius = tabBarSetting.preferredCornerRadius
        }
        modalPresentationStyle = .pageSheet
    }
    
    struct TabBarSetting {
        let detents: [UISheetPresentationController.Detent] = [ .medium() ]
        let prefersGrabberVisible = true
        let preferredCornerRadius: CGFloat = 24
    }
    
}
