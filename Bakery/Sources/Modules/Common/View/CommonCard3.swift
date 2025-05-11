//
//  CommonCard.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 10.05.2025.
//

//import UIKit
//
//final class CommonCard3: UIView {
//    // Элементы интерфейса
////    private let titleLabel = UILabel()
////    private let valueLabel = UILabel()
////    private let iconImageView = UIImageView()
//    
//    private let vm: CommonCardViewModel
//
//    // Обработчик нажатия
//    var onTap: (() -> Void)?
//
//    init(vm:CommonCardViewModel, frame: CGRect) {
//        self.vm = vm
//        super.init(frame: frame)
//        setupView()
//        setupGesture()
//    }
////
////    required init?(vm:CommonCardViewModel, coder: NSCoder) {
////        self.vm = vm
////        super.init(coder: coder)
////        setupView()
////        setupGesture()
////    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//func randomString3(length: Int, allowedCharacters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") -> String {
//    let characters = Array(allowedCharacters)
//    return String((0..<length).map { _ in characters.randomElement()! })
//}
//
//private extension CommonCard3 {
//    func setupView() {
//        // Настройка фона и скругления
//        //backgroundColor = .systemGray6
//        //backgroundColor = .red
//        layer.cornerRadius = 12
//        clipsToBounds = true
//        onTap = vm.onTap
//        
//        var iconImageView = UIImageView()
//        //var contentView = UIView()
//        
//        var titleLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, topMargin: .zero), padding: .init())
//        var titleViewModel = DSLabelViewModel(identifier: randomString(length: 6), text: vm.title, style: .beautyful, state: .default, size: .l, layout: titleLayout)
//        
//        var valueLayout = DSLayout(margin: DSLayoutMarging(hAlign: .center, topMargin: .zero, bottomMargin: .zero), padding: .init())
//        var valueViewModel = DSLabelViewModel(identifier: randomString(length: 6), text: vm.text, style: .beautyful, state: .default, size: .m, layout: valueLayout)
//        
//        //var titleLabel = ComponentFactory.makeView(from: titleViewModel)
//        //var valueLabel = UILabel()
//        
//        var contentLayot = DSLayout(margin: DSLayoutMarging(width:.fill, topMargin: .zero, bottomMargin: .zero, HMargin: .zero), padding: .init())
//        var content = DSContainerViewModel(identifier: randomString(length: 6), layout: contentLayot, items: [titleViewModel, valueViewModel], bottomView: 1)
//        
//        var contentView = ComponentFactory.makeView(from: content)
//        
//        
//        self.clipsToBounds = true
//        // Добавление элементов
//        addSubview(iconImageView)
//        addSubview(contentView)
//        
//        
//        
//        
//        
//        let scale = UIImage.kiev.size.width / (self.bounds.width)
//        print("scale \(scale)")
//        print("common card \(self.bounds)")
//        // Настройка изображения
//        //iconImageView.image = UIImage.init(color: .appPink) //?.resizableImage(withCapInsets: .zero)
//        //iconImageView.contentMode = .scaleAspectFit
//        iconImageView.image = vm.backroundImageView
//        iconImageView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        iconImageView.contentMode = vm.contentMode
////        scale = UIImage.kiev.size.width / (self.bounds.width)
////        print("scale \(scale)")
////        image = UIImage.kiev.scaled(by: scale)?.resizableImage(withCapInsets: .zero)
//        
//        // Настройка текста
//        //titleLabel.text = "Fairy cakes"
////        titleLabel.text = vm.title
////        titleLabel.textColor = .white
////        titleLabel.font = UIFont(name: "Zapfino", size: 50)
////        titleLabel.translatesAutoresizingMaskIntoConstraints = false
////        titleLabel.numberOfLines = 0
////        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
////        titleLabel.adjustsFontSizeToFitWidth = false
////        titleLabel.textAlignment = .center
////        
////        //valueLabel.text = "Вход/Регистрация"
////        valueLabel.text = vm.text
////        valueLabel.textColor = .white
////        valueLabel.font = UIFont(name: "Zapfino", size: 30) //UIFont.systemFont(ofSize: 16)
////        valueLabel.translatesAutoresizingMaskIntoConstraints = false
////        valueLabel.numberOfLines = 0
////        valueLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
////        valueLabel.adjustsFontSizeToFitWidth = false
////        valueLabel.textAlignment = .center
//        
//        //titleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
////        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: titleLabel.intrinsicContentSize.height).isActive = true
////        valueLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: valueLabel.intrinsicContentSize.height).isActive = true
////        titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: titleLabel.intrinsicContentSize.width).isActive = true
////        valueLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: valueLabel.intrinsicContentSize.width).isActive = true
//        
////        if (!vm.title.isEmpty && !vm.text.isEmpty){
////            contentView.addSubview(titleLabel)
////            contentView.addSubview(valueLabel)
////            
////            NSLayoutConstraint.activate([
////
////                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
////                titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
////                valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
////                valueLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
////                valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16)
////
////            ])
////        }
////        else if (!vm.title.isEmpty){
////            contentView.addSubview(titleLabel)
////            NSLayoutConstraint.activate([
////                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
////                titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
////                titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16)
////
////            ])
////        }
////        else if (!vm.text.isEmpty){
////            contentView.addSubview(valueLabel)
////            NSLayoutConstraint.activate([
////                valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
////                valueLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
////                valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16)
////            ])
////        }
//        
//        applyLayoutToView(layout: contentLayot.margin, view: contentView, topView: nil, botView: nil, superview: self)
//
//        // Констрейнты
//        NSLayoutConstraint.activate([
//            iconImageView.topAnchor.constraint(equalTo: topAnchor),
//            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
////            iconImageView.heightAnchor.constraint(
////                    equalTo: iconImageView.widthAnchor,
////                    multiplier: vm.backroundImageView.size.height / vm.backroundImageView.size.width // Сохраняем пропорции
////                ),
//            
////            contentView.topAnchor.constraint(equalTo: topAnchor),
////            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
////            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
////            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            
//        ])
//        
////        if (!vm.title.isEmpty){
////            NSLayoutConstraint.activate([
////
////                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
////                //titleLabel.leadingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
////                //titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
////                titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
////
////            ])
////        }
////        if (!vm.text.isEmpty){
////            NSLayoutConstraint.activate([
////                valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
////                valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
////            ])
////        }
////        if (vm.title.isEmpty && vm.text.isEmpty){
////            iconImageView.contentMode = .scaleAspectFill
////            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = false
////        }
////        else if (!vm.text.isEmpty){
////            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16).isActive = true
////        }
////        else if (!vm.title.isEmpty){
////            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16).isActive = true
////        }
//    }
//}
//
//private extension CommonCard {
//    func setupGesture() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//        addGestureRecognizer(tapGesture)
//        isUserInteractionEnabled = true // Важно!
//    }
//
//    @objc func handleTap() {
//        // Анимация нажатия
//        UIView.animate(withDuration: 0.1) {
//            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
//        } completion: { _ in
//            UIView.animate(withDuration: 0.1) {
//                self.transform = .identity
//            }
//        }
//
//        onTap?() // Вызов обработчика
//    }
//}
