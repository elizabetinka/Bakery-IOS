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

        vm?.card0.content = createContenrView0(activityState: .running, title: "Fairy cakes", titleId: "Fairy cakes", text: "Вход/Регистрация", textId: "commonCardEnter")
        let viewModel = Common.LoadingUserInfo.ViewModel(state: .setup(model: vm!))
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentLoadingItem(response: Common.LoadingItem.Response){
        if (vm == nil){
            vm = getInitialViewModel()
        }
        vm?.card2.content = createContenrView1(activityState: .running)
        
        let viewModel = Common.LoadingItem.ViewModel(state: .setup(model: vm!))
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentLoadingAction(response: Common.LoadingAction.Response){
        if (vm == nil){
            vm = getInitialViewModel()
        }
        vm?.card1.content = createContenrView1(activityState: .running)
        
        let viewModel = Common.LoadingAction.ViewModel(state: .setup(model: vm!))
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    private func setError(cardNumber: Int, error: String){
        switch cardNumber {
        case 0:

            vm?.card0.content = createContenrView0(activityState: .stopped, title: nil, titleId: nil, text: error, textId: "commonCardEnter")
        case 1:

            vm?.card1.content = createContenrView1(activityState: .stopped, text: error, textId: "card1Description")
        default:

            vm?.card2.content = createContenrView1(activityState: .stopped, text: error, textId: "card2Description")
        }
    }
    
    private func setNotAuth(){
        vm?.card0.content = createContenrView0(activityState: .stopped, title: "Fairy cakes", titleId: "Fairy cakes", text: "Вход/Регистрация", textId: "commonCardEnter")
    }
    
    private func setUserInfo(user: UserModel){
        vm?.card0.content = createContenrView0(activityState: .stopped, title: "Fairy cakes", titleId: "Fairy cakes", text: "Привет, \(user.name)", textId: "commonCardEnter")
    }
    
    private func setItem(item:ItemModel){
        guard item.itemImage != nil else { return }
        vm?.card2.backroundImageView = item.itemImage!
        vm?.card2.content = createContenrView1(activityState: .stopped, text: nil, textId: nil)
    }
    
    private func setAction(action:ActionModel){
        guard action.image != nil else { return }
        vm?.card1.backroundImageView = action.image!
        vm?.card1.content = createContenrView1(activityState: .stopped, text: nil, textId: nil)
    }
    
    private func  getInitialViewModel() -> CommonViewModel {

        let cont0 = createContenrView0(activityState: .stopped, title: "Fairy cakes", titleId:"Fairy cakes" , text: "Вход/Регистрация", textId: "commonCardEnter")
        
        let card0Layout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .s, HMargin: .m))
        
        var card0 = CommonCardViewModel( backroundImageView: UIImage.init(color: .appPink) ?? UIImage.init(), style: .text, layout: card0Layout, content: cont0)
        
        card0.onTap = cardsDelegate?.didTapUserCard
        
        
        let cont1 = createContenrView1(activityState: .stopped, text: "Акции", textId: "card1Description")
        
        
        let promotionLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .l, HMargin: .m))
        let promotionViewModel = DSLabelViewModel(identifier: "promotionLabel", text: "Акции и новости", style: .commonEnumeration, state: .default, size: .m, layout: promotionLayout)

        let card1Layout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .xs, HMargin: .m))
        
        let image1 = UIImage.init(color: .appSoftGray)!
        var card1 = CommonCardViewModel(backroundImageView: image1, style: .image, size: .medium, layout: card1Layout, content: cont1)
        
        card1.onTap = cardsDelegate?.didTapActionCard
        
        
        let cont2 = createContenrView1(activityState: .stopped, text: "Меню", textId: "card2Description")
        
        let promotionLayout2 = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .l, HMargin: .m))
        let promotionViewModel2 = DSLabelViewModel(identifier: "promotionLabel2", text: "Посмотреть меню", style: .commonEnumeration, state: .default, size: .m, layout: promotionLayout2)
        
        
        let card2Layout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .xs, bottomMargin: .zero, HMargin: .m))
        
        let image2 = UIImage.init(color: .appSoftGray)!
        var card2 = CommonCardViewModel(backroundImageView: image2, style: .image, size: .medium, layout: card2Layout, content: cont2)
        
        card2.onTap = cardsDelegate?.didTapItemCard
        
        return CommonViewModel(card0: card0, promotionViewModel: promotionViewModel, card1: card1, promotionViewModel2: promotionViewModel2, card2: card2)
    }
    
    
    private func createContenrView0(activityState: DSActivityIndicatorState, title: String? = nil,titleId: String? = nil, text: String? = nil,textId: String? = nil) -> DSContainerViewModel{
        
        
        let activityIndicatorLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, vAlign: .center), padding: DSLayoutPadding())
        
        let activityIndicator = DSActivityIndicatorViewModel(state: activityState, size: .large, style: .primary, layout: activityIndicatorLayout)
        
        let titleLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, topMargin: .zero), padding: .init())
        let titleViewModel = (title == nil || titleId == nil) ? nil : DSLabelViewModel(identifier: titleId!, text: title!, style: .beautyful, state: .default, size: .l, layout: titleLayout)
        
        let valueLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, topMargin: .zero, bottomMargin: .zero), padding: .init())
        let valueViewModel = (text == nil || textId == nil) ? nil : DSLabelViewModel(identifier: textId!, text: text!, style: .beautyful, state: .default, size: .m, layout: valueLayout)
        
        
        var items: [any DSViewModel] = []
        var bottomview = -1
        var topView = -1
        if let titleViewModel = titleViewModel {
            items.append(titleViewModel)
            if (titleViewModel.layout.margin.vAlign == .auto){
                bottomview  += 1
                topView = 0
            }
        }
        if let valueViewModel = valueViewModel {
            items.append(valueViewModel)
            if (valueViewModel.layout.margin.vAlign == .auto){
                bottomview  += 1
                topView = 0
            }
        }
        items.append(activityIndicator)
        let contentLayot = DSLayout(margin: DSLayoutMarging(width:.fill, topMargin: .zero, bottomMargin: .zero, HMargin: .zero), padding: .init())
        
        let container = DSContainerViewModel(layout: contentLayot, items: items, topView: topView, bottomView: bottomview)
        return container
        
    }
    
    
    private func createContenrView1(activityState: DSActivityIndicatorState, text: String? = nil,textId: String? = nil) -> DSContainerViewModel{
        
        
        let activityIndicatorLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, vAlign: .center), padding: DSLayoutPadding())
        
        let activityIndicator = DSActivityIndicatorViewModel(state: activityState, size: .large, style: .primary, layout: activityIndicatorLayout)
        
        let valueLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, vAlign: .center,topMargin: .zero, bottomMargin: .zero), padding: .init())
        let valueViewModel = (text == nil || textId == nil) ? nil : DSLabelViewModel(identifier: textId!, text: text!, style: .primary, state: .default, size: .s, layout: valueLayout)
        
        
        var items: [any DSViewModel] = []
        var bottomview = -1
        var topView = -1
        if let valueViewModel = valueViewModel {
            items.append(valueViewModel)
            if (valueViewModel.layout.margin.vAlign == .auto){
                bottomview  += 1
                topView = 0
            }
        }
        items.append(activityIndicator)
        let contentLayot = DSLayout(margin: DSLayoutMarging(width:.fill, topMargin: .zero, bottomMargin: .zero, HMargin: .zero), padding: .init())
        
        let container = DSContainerViewModel(layout: contentLayot, items: items, topView: topView, bottomView: bottomview)
        return container
        
    }
    
}
