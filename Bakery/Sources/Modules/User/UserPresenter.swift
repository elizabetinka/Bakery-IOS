//
//  User actions module
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

@MainActor
protocol UserPresentationLogic {
    func presentInitialData(response: User.Init.Response)
    func presentLoadingData(response: User.Loading.Response)
    func presentReloadData(response: User.Reload.Response)
}

@MainActor
/// Отвечает за отображение данных модуля User
class UserPresenter: UserPresentationLogic {
    weak var viewController: UserDisplayLogic?
    weak var refreshActionsDelegate: ErrorViewDelegate?
    
    var vm: UserViewModel?
    
    func presentInitialData(response: User.Init.Response) {
        var viewModel: User.Init.ViewModel
        
        switch response.result {
        case let .failure(error):
            vm = getInitialViewModel()
            setError(error: error.localizedDescription)
            viewModel = User.Init.ViewModel(state: .setup(model: vm!))
        case let .success(result):
            vm = getInitialViewModel(name: result.name, phoneNumber: result.phoneNumber, bonus: String(result.points), status: "Карта 3%")
            viewModel = User.Init.ViewModel(state: .setup(model: vm!))
        case .notAuthorized:
            vm = getInitialViewModel()
            viewModel = User.Init.ViewModel(state: .notAuthorized)
        }
        
        guard vm != nil else { return }
        vm!.activityIndicator?.state = .stopped
        
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentLoadingData(response: User.Loading.Response) {
        guard vm != nil else { return }
        vm?.activityIndicator?.state = .running
        let viewModel = User.Loading.ViewModel(state: .configure(model: vm!))
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentReloadData(response: User.Reload.Response) {
        guard vm != nil else { return }
        vm?.errorModel?.state = .hidden
        let viewModel = User.Reload.ViewModel(state: .configure(model: vm!))
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    private func setError(error: String){
        guard vm != nil else { return }
        vm?.errorModel?.state = .error
        vm?.errorModel?.title?.text = error
    }
    
    private func  getInitialViewModel(name: String = "неизвестное имя", phoneNumber: String = "неизвестный номер телефона", bonus: String = "unknown", status: String = "unknown") -> UserViewModel {
        var model = UserViewModel()
        
        let nameLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .m, HMargin: .m), padding: DSLayoutPadding())
        
        model.nameLabel = DSLabelViewModel(text: name, style: .primary, state: .default, size: .l, layout: nameLayout)
        
        let phoneLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .m, HMargin: .m), padding: DSLayoutPadding())
        
        model.phoneLabel = DSLabelViewModel(text: phoneNumber, style: .primary, state: .default, size: .m, layout: phoneLayout)

        let bonusCard = getUserInfoCardViewModel(title: "Бонусы", value: bonus, image: .points, iconId: "iconPoints", titleId: "userInfoTitleLabelPoints", valueId: "userInfoValueLabelPoints", stackId: "headerStackPoints")
        let statusCard = getUserInfoCardViewModel(title: "Текущий статус", value: status, image: .statistics, iconId: "iconStatistics", titleId: "userInfoTitleLabelStatistics", valueId: "userInfoValueLabelStatistics", stackId: "headerStackStatistics")
        

        let stackLayout = DSLayout(margin: DSLayoutMarging(width: .fill,height: .fixed(CGFloat(120)), topMargin: .l,  HMargin: .m))
        model.stackCards = DSStackViewModel(identifier: "cards", style: .horizontal, size: .m, alignment: .equal, layout: stackLayout, items: [bonusCard, statusCard])
        
        model.errorModel = getInitialErrorViewModel()
        
        
        let activityIndicatorLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, vAlign: .center), padding: DSLayoutPadding())
        
        model.activityIndicator = DSActivityIndicatorViewModel(state: .stopped, size: .large, style: .primary, layout: activityIndicatorLayout)
        
        
        return model
        
    }
    
    private func getUserInfoCardViewModel(title: String, value: String, image: UIImage, iconId: String = "icon", titleId: String = "userInfoTitleLabel", valueId: String = "userInfoValueLabel", stackId: String = "headerStack") -> UserInfoCardModelViewModel {
        var vm = UserInfoCardModelViewModel()
        
        let iconLayout = DSLayout()
        let icon = DSImageViewModel(identifier: iconId,image: image, size: .icon, layout: iconLayout)
        
        let titleLayout = DSLayout()
        let titleLabel = DSLabelViewModel(identifier: titleId,text: title, style: .primary, state: .default, size: .m, layout: titleLayout)
        
        let stackLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .s, HMargin: .m))
        vm.headerStack = DSStackViewModel(identifier: stackId, style: .horizontal, size: .s, alignment: .center,layout: stackLayout, items: [icon, titleLabel])
    
        
        let valueLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .xs,  leftMargin: .m))
        vm.valueLabel = DSLabelViewModel(identifier: valueId, text: value, style: .primary, state: .default, size: .m, layout: valueLayout)
        
        return vm
    }
    
    private func getInitialErrorViewModel() -> ErrorViewModel {
        var errorModel = ErrorViewModel()
        
        let buttonLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, topMargin: .l, bottomMargin: .s), padding: DSLayoutPadding(VPadding: .xs, HPadding: .m))
        
        errorModel.refreshButton = DSButtonViewModel(title: "Try again", style: .neutral, size: .medium, state: .default,layout: buttonLayout, onTap: refreshActionsDelegate?.reloadButtonWasTapped)
        errorModel.refreshButton?.identifier = "refreshButton"
        
        let titleLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .m, HMargin: .l), padding: DSLayoutPadding())
        
        errorModel.title = DSLabelViewModel(text: "Uncnown error", style: .primary, state: .default, size: .m, layout: titleLayout)
        errorModel.title?.identifier = "errorLabel"
        
        errorModel.layout = DSLayout(margin: DSLayoutMarging(width: .fill, hAlign: .center, vAlign: .center, HMargin: .xl))


        return errorModel
    }
}
