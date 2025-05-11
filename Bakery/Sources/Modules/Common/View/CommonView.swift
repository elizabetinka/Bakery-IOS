//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

//@MainActor
//extension CommonView {
//    struct Appearance {
//        let exampleOffset: CGFloat = 10
//        let backgroundColor = UIColor.white
//        let labelFont = UIFont.systemFont(ofSize: 17, weight: .medium)
//    }
//    
//}

@MainActor
protocol CommonViewProtocol : ViewProtocol {
    func configure(with model: CommonViewModel)
    func setup(with model: CommonViewModel)
}

@MainActor
class CommonView: UIView {
    //let appearance = Appearance()
    
//    fileprivate(set) lazy var tableView: UITableView = {
//        let view = UITableView(frame: .zero, style: .plain)
//        return view
//    }()
    
//    lazy var errorView: ErrorView = {
//            let view = ErrorView()
//            //view.delegate = self.refreshActionsDelegate
//            return view
//        }()

   // weak var refreshActionsDelegate: ErrorViewDelegate?


    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        
        //configureTableView(tableDataSource: tableDataSource, tableDelegate:tableDelegate)
        //refreshActionsDelegate = refreshDelegate
        //backgroundColor=appearance.backgroundColor
        addSubviews()
        //makeConstraints()
        
        
        //tableView.isHidden = true
        //errorView.isHidden = true
    }
    
    // MARK: - Private Methods
//    private func configureTableView(tableDataSource: UITableViewDataSource,
//                                    tableDelegate: UITableViewDelegate) {
//        tableView.dataSource = tableDataSource
//        tableView.delegate = tableDelegate
//    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let scrollView = UIScrollView()
    var contentView: DSView?
    private var viewModel: CommonViewModel?
    
    func setup(with model: CommonViewModel){
        viewModel = model
        
        backgroundColor = model.style.backgroundColor
        
        let content = model.content
        contentView = ComponentFactory.makeView(from: content)
        
        if (contentView == nil){
            return
        }
        //print("after setup")
        //print("after content view frame \(String(describing: contentView?.frame))")
        contentView!.translatesAutoresizingMaskIntoConstraints = false

        scrollView.subviews.forEach { $0.removeFromSuperview() }
        
        scrollView.addSubview(contentView!)

        contentView!.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            contentView!.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView!.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView!.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView!.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView!.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    func configure(with model: CommonViewModel){
        viewModel = model
        
        backgroundColor = model.style.backgroundColor
        
        let content = model.content
        
        guard contentView != nil else { return }
        
        contentView!.configure(with: content)
    }
    
    
    func addSubviews(){
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    
    func addSubviews2(){
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
            
        
        var titleLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, topMargin: .zero), padding: .init())
        var titleViewModel = DSLabelViewModel(identifier: "Fairy cakes", text: "Fairy cakes", style: .beautyful, state: .default, size: .l, layout: titleLayout)
        
        var valueLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, topMargin: .zero, bottomMargin: .zero), padding: .init())
        var valueViewModel = DSLabelViewModel(identifier: "commonCardEnter", text: "Вход/Регистрация", style: .beautyful, state: .default, size: .m, layout: valueLayout)
        
        let activityIndicatorLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, vAlign: .center), padding: DSLayoutPadding())
        
        let activityIndicator = DSActivityIndicatorViewModel(state: .stopped, size: .large, style: .primary, layout: activityIndicatorLayout)
        
        let card0Layout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .s, HMargin: .m))
        
        var card0VM = CommonCardViewModel(title: titleViewModel, text: valueViewModel, activityIndicator: activityIndicator, backroundImageView: UIImage.init(color: .appPink) ?? UIImage.init(), style: .text, layout: card0Layout)
        
        card0VM.onTap = {
            print("Карточка 0 нажата!")
        }
        
        
        var promotionLayout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .l, HMargin: .m))
        var promotionViewModel = DSLabelViewModel(identifier: "promotionLabel", text: "Акции и новости", style: .commonEnumeration, state: .default, size: .m, layout: promotionLayout)
        
        
        let card1Layout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .xs, HMargin: .m))
        
        var image1 = UIImage.dubai.scaled(by: 3)?.resizableImage(withCapInsets: .zero) ?? UIImage()
        var card1VM = CommonCardViewModel(activityIndicator: activityIndicator, backroundImageView: image1, style: .image, size: .medium, layout: card1Layout)
        
        card1VM.onTap = {
            print("Карточка 1 нажата!")
        }
        
        
        var promotionLayout2 = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .l, HMargin: .m))
        var promotionViewModel2 = DSLabelViewModel(identifier: "promotionLabel2", text: "Посмотреть меню", style: .commonEnumeration, state: .default, size: .m, layout: promotionLayout2)
        
        
        let card2Layout = DSLayout(margin: DSLayoutMarging(width: .fill, topMargin: .xs, bottomMargin: .zero, HMargin: .m))
        
        var image2 = UIImage.kiev.scaled(by: 1.8)?.resizableImage(withCapInsets: .zero) ?? UIImage()
        var card2VM = CommonCardViewModel(activityIndicator: activityIndicator, backroundImageView: image2, style: .image, size: .medium, layout: card2Layout)
        
        card2VM.onTap = {
            print("Карточка 2 нажата!")
        }
        
        
        let content = DSContainerViewModel(identifier: "commonView", items: [card0VM, promotionViewModel, card1VM, promotionViewModel2, card2VM], topView: 0, bottomView: 4)
        
        
        contentView = ComponentFactory.makeView(from: content)
        
        scrollView.addSubview(contentView!)

        // Констрейнты для contentView
        contentView!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView!.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView!.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView!.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView!.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView!.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        
        //let card0 = CommonCard(vm: card0VM, frame: .zero)
        //card0.translatesAutoresizingMaskIntoConstraints = false

        // Установите обработчик нажатия
        

        
//        let promotionsTitle = UILabel()
//        promotionsTitle.textColor = .gray
//        promotionsTitle.text = "акции и новости"
//        promotionsTitle.font = UIFont.boldSystemFont(ofSize: 20)
     
        
//        var scale = UIImage.dubai.size.width / (self.bounds.width-32)
//        print("dubai \(scale)")
//        var image = UIImage.dubai.scaled(by: 3)?.resizableImage(withCapInsets: .zero)
//        let card1VM = CommonCardViewModel(title: "", text: "", backroundImageView: image ?? UIImage.init(), style: .image, size: .medium)
//        var card1 = CommonCard(vm: card1VM, frame: .zero)
//        card1.translatesAutoresizingMaskIntoConstraints = false

        // Установите обработчик нажатия
//        card1.onTap = {
//            print("Карточка 1 нажата!")
//        }
//        
        
//        let promotionsTitle2 = UILabel()
//        promotionsTitle2.textColor = .gray
//        promotionsTitle2.text = "посмотреть меню"
//        promotionsTitle2.font = UIFont.boldSystemFont(ofSize: 20)
//        
//        scale = UIImage.kiev.size.width / (self.bounds.width-32)
//        print("kiev \(scale)")
//        image = UIImage.kiev.scaled(by: 1.8)?.resizableImage(withCapInsets: .zero)
//        let card2VM = CommonCardViewModel(title: "", text: "", backroundImageView: image ?? UIImage.init(), style: .image, size: .medium)
//        var card2 = CommonCard(vm: card2VM, frame: .zero)
//        card2.translatesAutoresizingMaskIntoConstraints = false
//
//        card2.onTap = {
//            print("Карточка 2 нажата!")
//        }
//
//
//        //card0.heightAnchor.constraint(equalToConstant: 170).isActive = true
//        card1.heightAnchor.constraint(equalToConstant: 170).isActive = true
//        card2.heightAnchor.constraint(equalToConstant: 170).isActive = true
//
//        contentView.addSubview(card0)
//        contentView.addSubview(promotionsTitle)
//        contentView.addSubview(card1)
//        contentView.addSubview(promotionsTitle2)
//        contentView.addSubview(card2)
//        
//        card0.translatesAutoresizingMaskIntoConstraints = false
//        card1.translatesAutoresizingMaskIntoConstraints = false
//        card2.translatesAutoresizingMaskIntoConstraints = false
//        promotionsTitle.translatesAutoresizingMaskIntoConstraints = false
//        promotionsTitle2.translatesAutoresizingMaskIntoConstraints = false
//        
//        
//        NSLayoutConstraint.activate([
//            card0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
//            card0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            card0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            
//            promotionsTitle.topAnchor.constraint(equalTo: card0.bottomAnchor, constant: 48),
//            promotionsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            promotionsTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            
//            card1.topAnchor.constraint(equalTo: promotionsTitle.bottomAnchor, constant: 8),
//            card1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            card1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            
//            promotionsTitle2.topAnchor.constraint(equalTo: card1.bottomAnchor, constant: 48),
//            promotionsTitle2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            promotionsTitle2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            
//            card2.topAnchor.constraint(equalTo: promotionsTitle2.bottomAnchor, constant: 8),
//            card2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            card2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            card2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//        ])
    }

    func makeConstraints() {
    }
//    

    func showUserLoading() {
        //show(view: tableView)
    }
    
    func showItemLoading() {
        //show(view: tableView)
    }

    func showError(message: String) {
        //show(view: errorView)
        //errorView.title.text = message
    }


    func show(view: UIView) {
        //subviews.forEach { $0.isHidden = (view != $0) }
    }

    func updateTableViewData(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
//        show(view: tableView)
//        tableView.tableFooterView = nil
//        tableView.tableHeaderView = nil
//        tableView.dataSource = dataSource
//        tableView.delegate = delegate
//        tableView.reloadData()
    }
}
