//
//  Отвечает за логику главного экрана
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

@MainActor
protocol CommonPresentationLogic {
    func presentUserInfo(response: Common.ShowUserInfo.Response)
    func presentItem(response: Common.ShowItem.Response)
    func presentAction(response: Common.ShowAction.Response)
    
    func presentLoadingUserInfo(response: Common.LoadingUserInfo.Response)
    func presentLoadingItem(response: Common.LoadingItem.Response)
    func presentLoadingAction(response: Common.LoadingAction.Response)
}

@MainActor
/// Отвечает за отображение данных модуля Common
class CommonPresenter: CommonPresentationLogic {
    weak var viewController: CommonDisplayLogic?
    weak var cardsDelegate: CardsDelegate?
    lazy var vm: CommonViewModel? = getInitialViewModel()
    
    // MARK: Do something
    func presentUserInfo(response: Common.ShowUserInfo.Response) {
        if (vm == nil){
            vm = getInitialViewModel()
        }
        var viewModel: Common.ShowUserInfo.ViewModel
        vm!.card0.activityIndicator.state = .stopped
        switch response.result {
        case let .failure(error):
            setError(cardNumber: 0, error: error.localizedDescription)
        case let .success(result):
            setUserInfo(user: result)
        case .notAuthorized:
            setNotAuth()
        }
        viewModel = Common.ShowUserInfo.ViewModel(state: .setup(model: vm!))
        viewController?.displayUserInfo(viewModel: viewModel)
    }
    
    func presentItem(response: Common.ShowItem.Response) {
        if (vm == nil){
            vm = getInitialViewModel()
        }
        var viewModel: Common.ShowItem.ViewModel
        vm!.card2.activityIndicator.state = .stopped
        switch response.result {
        case let .failure(error):
            setError(cardNumber: 1, error: error.localizedDescription)
        case let .success(result):
            setItem(item: result)
        }
        viewModel = Common.ShowItem.ViewModel(state: .setup(model: vm!))
        viewController?.displayItem(viewModel: viewModel)
    }
    
    func presentAction(response: Common.ShowAction.Response) {
        if (vm == nil){
            vm = getInitialViewModel()
        }
        var viewModel: Common.ShowAction.ViewModel
        vm!.card1.activityIndicator.state = .stopped
        switch response.result {
        case let .failure(error):
            setError(cardNumber: 2, error: error.localizedDescription)
        case let .success(result):
            setAction(action: result)
        }
        viewModel = Common.ShowAction.ViewModel(state: .setup(model: vm!))
        viewController?.displayAction(viewModel: viewModel)
    }
    
    func presentLoadingUserInfo(response: Common.LoadingUserInfo.Response){
        if (vm == nil){
            vm = getInitialViewModel()
        }
        vm!.card0.activityIndicator.state = .running
        let viewModel = Common.LoadingUserInfo.ViewModel(state: .setup(model: vm!))
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentLoadingItem(response: Common.LoadingItem.Response){
        if (vm == nil){
            vm = getInitialViewModel()
        }
        vm!.card2.activityIndicator.state = .running
        let viewModel = Common.LoadingItem.ViewModel(state: .setup(model: vm!))
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentLoadingAction(response: Common.LoadingAction.Response){
        if (vm == nil){
            vm = getInitialViewModel()
        }
        vm!.card1.activityIndicator.state = .running
        let viewModel = Common.LoadingAction.ViewModel(state: .setup(model: vm!))
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    private func setError(cardNumber: Int, error: String){
        switch cardNumber {
        case 0:
            vm?.card0.text?.text = error
        case 1:
            vm?.card1.text?.text = error
        default:
            vm?.card2.text?.text = error
        }
    }
    
    private func setNotAuth(){
        vm?.card0.text?.text = "Вход/Регистрация"
        vm?.card0.title?.text = "Fairy cakes"
    }
    
    private func setUserInfo(user: UserModel){
        vm?.card0.text?.text = "Привет, \(user.name)"
    }
    
    private func setItem(item:ItemModel){
        guard item.itemImage != nil else { return }
        let image = item.itemImage!//.scaled(by:1.8)?.resizableImage(withCapInsets: .zero)
        vm?.card2.backroundImageView = item.itemImage!
        vm?.card2.text = nil
    }
    
    private func setAction(action:ActionModel){
        guard action.image != nil else { return }
        vm?.card1.backroundImageView = action.image!
        vm?.card1.text = nil
    }
    
    private func  getInitialViewModel() -> CommonViewModel {
        var titleLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, topMargin: .zero), padding: .init())
        var titleViewModel = DSLabelViewModel(identifier: "Fairy cakes", text: "Fairy cakes", style: .beautyful, state: .default, size: .l, layout: titleLayout)
        
        var valueLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, topMargin: .zero, bottomMargin: .zero), padding: .init())
        var valueViewModel = DSLabelViewModel(identifier: "commonCardEnter", text: "Вход/Регистрация", style: .beautyful, state: .default, size: .m, layout: valueLayout)
        
        let activityIndicatorLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, vAlign: .center), padding: DSLayoutPadding())
        
        let activityIndicator = DSActivityIndicatorViewModel(state: .stopped, size: .large, style: .primary, layout: activityIndicatorLayout)
        
        let card0Layout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .s, HMargin: .m))
        
        var card0 = CommonCardViewModel(title: titleViewModel, text: valueViewModel, activityIndicator: activityIndicator, backroundImageView: UIImage.init(color: .appPink) ?? UIImage.init(), style: .text, layout: card0Layout)
        
        card0.onTap = cardsDelegate?.didTapUserCard
        
        
        var promotionLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .l, HMargin: .m))
        var promotionViewModel = DSLabelViewModel(identifier: "promotionLabel", text: "Акции и новости", style: .commonEnumeration, state: .default, size: .m, layout: promotionLayout)
        
        var valueLayout1 = DSLayout(margin: DSLayoutMarging(hAlign: .center, vAlign: .center), padding: .init())
        var valueViewModel1 = DSLabelViewModel(identifier: "card1Description", text: "Акции", style: .primary, state: .default, size: .s, layout: valueLayout1)
        
        let card1Layout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .xs, HMargin: .m))
        
        var image1 = UIImage.init(color: .appSoftGray)!
        var card1 = CommonCardViewModel(text: valueViewModel1, activityIndicator: activityIndicator, backroundImageView: image1, style: .image, size: .medium, layout: card1Layout)
        
        card1.onTap = cardsDelegate?.didTapActionCard
        
        
        var promotionLayout2 = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .l, HMargin: .m))
        var promotionViewModel2 = DSLabelViewModel(identifier: "promotionLabel2", text: "Посмотреть меню", style: .commonEnumeration, state: .default, size: .m, layout: promotionLayout2)
        
        
        var valueLayout2 = DSLayout(margin: DSLayoutMarging(hAlign: .center, vAlign: .center, topMargin: .zero, bottomMargin: .zero), padding: .init())
        var valueViewModel2 = DSLabelViewModel(identifier: "card2Description", text: "Меню", style: .primary, state: .default, size: .s, layout: valueLayout2)
        
        let card2Layout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .xs, bottomMargin: .zero, HMargin: .m))
        
        var image2 = UIImage.init(color: .appSoftGray)!
        var card2 = CommonCardViewModel(text: valueViewModel2, activityIndicator: activityIndicator, backroundImageView: image2, style: .image, size: .medium, layout: card2Layout)
        
        card2.onTap = cardsDelegate?.didTapItemCard
        
        return CommonViewModel(card0: card0, promotionViewModel: promotionViewModel, card1: card1, promotionViewModel2: promotionViewModel2, card2: card2)
    }
    
}
