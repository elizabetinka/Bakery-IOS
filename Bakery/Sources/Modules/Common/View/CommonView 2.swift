//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

//import UIKit
//
//@MainActor
//extension CommonView2 {
//    struct Appearance {
//        let exampleOffset: CGFloat = 10
//        let backgroundColor = UIColor.white
//        let labelFont = UIFont.systemFont(ofSize: 17, weight: .medium)
//    }
//    
//}
//
//@MainActor
//class CommonView2: UIView {
//    let appearance = Appearance()
//    
////    fileprivate(set) lazy var tableView: UITableView = {
////        let view = UITableView(frame: .zero, style: .plain)
////        return view
////    }()
//    
//    lazy var errorView: ErrorView = {
//            let view = ErrorView()
//            //view.delegate = self.refreshActionsDelegate
//            return view
//        }()
//
//    weak var refreshActionsDelegate: ErrorViewDelegate?
//
//
//    init(frame: CGRect = CGRect.zero, tableDataSource: UITableViewDataSource,
//                  tableDelegate: UITableViewDelegate,refreshDelegate: ErrorViewDelegate) {
//        super.init(frame: frame)
//        
//        //configureTableView(tableDataSource: tableDataSource, tableDelegate:tableDelegate)
//        refreshActionsDelegate = refreshDelegate
//        backgroundColor=appearance.backgroundColor
//        addSubviews()
//        makeConstraints()
//        
//        
//        //tableView.isHidden = true
//        errorView.isHidden = true
//    }
//    
//    // MARK: - Private Methods
////    private func configureTableView(tableDataSource: UITableViewDataSource,
////                                    tableDelegate: UITableViewDelegate) {
////        tableView.dataSource = tableDataSource
////        tableView.delegate = tableDelegate
////    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    let scrollView = UIScrollView()
//    let contentView = UIView()
//    
//    func addSubviews(){
//        addSubview(scrollView)
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
//        ])
//            
////        contentView.axis = .vertical
////        contentView.spacing = 20
//        scrollView.addSubview(contentView)
//
//        // Констрейнты для contentView
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
//        ])
//        
////        let headerStack = UIStackView()
////        headerStack.axis = .horizontal
////        headerStack.distribution = .equalSpacing
////        
////        let attributedString = NSMutableAttributedString()
////
////        // Добавляем "Коржов" с жирным шрифтом
////        let korzhovAttributes: [NSAttributedString.Key: Any] = [
////            .font: UIFont.boldSystemFont(ofSize: 16),
////            .foregroundColor: UIColor.white
////        ]
////        attributedString.append(NSAttributedString(string: "Fairy cackes", attributes: korzhovAttributes))
////
//////        // Добавляем пробел
//////        attributedString.append(NSAttributedString(string: " "))
////
////        // Добавляем "Регистрация" с обычным шрифтом
////        let registrationAttributes: [NSAttributedString.Key: Any] = [
////            .font: UIFont.systemFont(ofSize: 16),
////            .foregroundColor: UIColor.white
////        ]
////        attributedString.append(NSAttributedString(string: "\nРегистрация", attributes: registrationAttributes))
//        
//        
////        let card0 = UIButton(type: .custom)
////        //card0.backgroundColor = .systemGray6
////        card0.layer.cornerRadius = 12
//////        var scale = UIImage.kiev.size.width / (self.bounds.width-32)
//////        print("scale \(scale)")
//////        var image = UIImage.kiev.scaled(by: scale)?.resizableImage(withCapInsets: .zero)
//////        ///card1.setBackgroundImage(image, for: .normal)
//////        card0.setImage(image, for: .normal)
//////        //card1.imageView?.contentMode = .scaleAspectFill
//////        card0.imageView?.contentMode = .center
////        //card0.setTitle("Fairy cackes\nВход/Регистрация", for: .normal)
////        card0.setAttributedTitle(attributedString, for: .normal)
////        card0.backgroundColor = .appPink
////        card0.contentHorizontalAlignment = .center // Центрирование по горизонтали
////        card0.contentVerticalAlignment = .center   // Центрирование по вертикали
////        card0.clipsToBounds = true
//
////        // Логотип "КОРЖОВ"
////        let logoLabel = UILabel()
////        logoLabel.text = "КОРЖОВ"
////        logoLabel.font = UIFont.boldSystemFont(ofSize: 24)
////
////        // Кнопки "Вход / Регистрация"
////        let loginButton = UIButton(type: .system)
////        loginButton.setTitle("Вход", for: .normal)
////        let registerButton = UIButton(type: .system)
////        registerButton.setTitle("Регистрация", for: .normal)
//
////        headerStack.addArrangedSubview(logoLabel)
////        headerStack.addArrangedSubview(UIStackView(arrangedSubviews: [loginButton, registerButton]))
////
////        contentView.addArrangedSubview(headerStack)
//        
//        let promotionsTitle = UILabel()
//        promotionsTitle.textColor = .gray
//        promotionsTitle.text = "акции и новости"
//        promotionsTitle.font = UIFont.boldSystemFont(ofSize: 20)
//        //contentView.addArrangedSubview(promotionsTitle)
//
////        // Карточка 1: "открыли ПРЕДЪЯКАВ"
////        let card1 = UIButton(type: .custom)
////        card1.backgroundColor = .systemGray6
////        card1.layer.cornerRadius = 12
////        var scale = UIImage.kiev.size.width / (self.bounds.width-32)
////        print("scale \(scale)")
////        var image = UIImage.kiev.scaled(by: scale)?.resizableImage(withCapInsets: .zero)
////        ///card1.setBackgroundImage(image, for: .normal)
////        card1.setImage(image, for: .normal)
////        //card1.imageView?.contentMode = .scaleAspectFill
////        card1.imageView?.contentMode = .center
////        card1.contentHorizontalAlignment = .center // Центрирование по горизонтали
////        card1.contentVerticalAlignment = .center   // Центрирование по вертикали
////        card1.clipsToBounds = true
//        //card1.setTitle("открыли\nПРЕДЪЯКАВ", for: .normal)
//        //card1.titleLabel?.numberOfLines = 0
//        //card1.titleLabel?.textAlignment = .center
//
////        // Карточка 2: "оформите заказ..."
////        let card2 = UIButton(type: .custom)
////        card2.backgroundColor = .systemGray6
////        card2.layer.cornerRadius = 12
////        card2.setTitle("оформите заказ\n(за традиционный кулак)\n(и творожную пассу)", for: .normal)
////        card2.titleLabel?.numberOfLines = 0
////        card2.titleLabel?.textAlignment = .center
//        
//        
//        let promotionsTitle2 = UILabel()
//        promotionsTitle2.textColor = .gray
//        promotionsTitle2.text = "посмотреть меню"
//        promotionsTitle2.font = UIFont.boldSystemFont(ofSize: 20)
//        //contentView.addArrangedSubview(promotionsTitle2)
//
//        // Карточка 1: "открыли ПРЕДЪЯКАВ"
////        let card2 = UIButton(type: .custom)
////        card2.backgroundColor = .systemGray6
////        card2.layer.cornerRadius = 12
////        var scale = UIImage.kiev.size.width / (self.bounds.width-32)
////        print("scale \(scale)")
////        var image = UIImage.kiev.scaled(by: scale)?.resizableImage(withCapInsets: .zero)
////        ///card1.setBackgroundImage(image, for: .normal)
////        card2.setImage(image, for: .normal)
////        //card1.imageView?.contentMode = .scaleAspectFill
////        card2.imageView?.contentMode = .center
////        card2.contentHorizontalAlignment = .center // Центрирование по горизонтали
////        card2.contentVerticalAlignment = .center   // Центрирование по вертикали
////        card2.clipsToBounds = true
//
//        // Вертикальный стек для карточек
////        let cardsStack = UIStackView(arrangedSubviews: [promotionsTitle, card1, promotionsTitle2, card2])
////        cardsStack.axis = .vertical
////        cardsStack.spacing = 16
////        cardsStack.distribution = .fillEqually
//        //contentView.addSubview(cardsStack)
//        //Вход/Регистрация"
//        
//        let card0VM = CommonCardViewModel(title: "Fairy cakes", text: "Вход/Регистрация", backroundImageView: UIImage.init(color: .appPink) ?? UIImage.init(), contentMode: .scaleAspectFill)
//        let card0 = CommonCard(vm: card0VM, frame: .zero)
//        card0.translatesAutoresizingMaskIntoConstraints = false
//
//        // Установите обработчик нажатия
//        card0.onTap = {
//            print("Карточка 0 нажата!")
//        }
//        
//        var scale = UIImage.dubai.size.width / (self.bounds.width-32)
//        print("dubai \(scale)")
//        var image = UIImage.dubai.scaled(by: 3)?.resizableImage(withCapInsets: .zero)
//        let card1VM = CommonCardViewModel(title: "", text: "", backroundImageView: image ?? UIImage.init(), contentMode: .scaleAspectFill)
//        var card1 = CommonCard(vm: card1VM, frame: .zero)
//        card1.translatesAutoresizingMaskIntoConstraints = false
//
//        // Установите обработчик нажатия
//        card1.onTap = {
//            print("Карточка 1 нажата!")
//        }
//        
//        scale = UIImage.kiev.size.width / (self.bounds.width-32)
//        print("kiev \(scale)")
//        image = UIImage.kiev.scaled(by: 1.8)?.resizableImage(withCapInsets: .zero)
//        let card2VM = CommonCardViewModel(title: "", text: "", backroundImageView: image ?? UIImage.init(), contentMode: .scaleAspectFill)
//        var card2 = CommonCard(vm: card2VM, frame: .zero)
//        card2.translatesAutoresizingMaskIntoConstraints = false
//
//        // Установите обработчик нажатия
//        card2.onTap = {
//            print("Карточка 2 нажата!")
//        }
//
//
//        // Высота карточек
//        //card0.heightAnchor.constraint(equalToConstant: 170).isActive = true
//        card1.heightAnchor.constraint(equalToConstant: 170).isActive = true
//        card2.heightAnchor.constraint(equalToConstant: 170).isActive = true
//        //card.heightAnchor.constraint(equalToConstant: 170).isActive = true
//        
//        
////        let menuButton = UIButton(type: .system)
////        menuButton.setTitle("посмотреть меню", for: .normal)
////        menuButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        contentView.addSubview(card0)
//        contentView.addSubview(promotionsTitle)
//        contentView.addSubview(card1)
//        contentView.addSubview(promotionsTitle2)
//        contentView.addSubview(card2)
//        //contentView.addSubview(card)
//        
//        card0.translatesAutoresizingMaskIntoConstraints = false
//        card1.translatesAutoresizingMaskIntoConstraints = false
//        card2.translatesAutoresizingMaskIntoConstraints = false
//        promotionsTitle.translatesAutoresizingMaskIntoConstraints = false
//        promotionsTitle2.translatesAutoresizingMaskIntoConstraints = false
//        //card0.translatesAutoresizingMaskIntoConstraints = false
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
//            
////            card.topAnchor.constraint(equalTo: card2.bottomAnchor, constant: 8),
////            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
////            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
////            card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//        ])
//    }
//
//    func makeConstraints() {
//    }
////    
//
//    func showUserLoading() {
//        //show(view: tableView)
//    }
//    
//    func showItemLoading() {
//        //show(view: tableView)
//    }
//
//    func showError(message: String) {
//        //show(view: errorView)
//        //errorView.title.text = message
//    }
//
//
//    func show(view: UIView) {
//        //subviews.forEach { $0.isHidden = (view != $0) }
//    }
//
//    func updateTableViewData(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
////        show(view: tableView)
////        tableView.tableFooterView = nil
////        tableView.tableHeaderView = nil
////        tableView.dataSource = dataSource
////        tableView.delegate = delegate
////        tableView.reloadData()
//    }
//}
