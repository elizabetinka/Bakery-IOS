//
//  CommonCard.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 10.05.2025.
//

import UIKit

final class CommonCard: UIView, DSView {
    private var vm: CommonCardViewModel
    private var contentView: DSView?
    private var iconImageView = UIImageView()

    init(vm:CommonCardViewModel, frame: CGRect = CGRect.zero) {
        self.vm = vm
        super.init(frame: frame)
        setup()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        layer.cornerRadius = vm.style.cornerRadius
        clipsToBounds = true
        //print("bounds \(UIScreen.main.bounds.size)")
        //print("scale \(vm.backroundImageView.size.width/UIScreen.main.bounds.width)")
        let scale = vm.backroundImageView.size.width/(UIScreen.main.bounds.width)
        iconImageView.image = vm.backroundImageView.scaled(by: scale)?.resizableImage(withCapInsets: .zero) ?? vm.backroundImageView
        iconImageView.contentMode = vm.style.contentMode()

        let contentModel = vm.content
        contentView = ComponentFactory.makeView(from: contentModel)
        if (contentView == nil){
            return
        }

        self.subviews.forEach { $0.removeFromSuperview() }
        
        addSubview(iconImageView)
        addSubview(contentView!)
    }
    
    func configure(with viewModel: DSViewModel) {
        guard let viewModel = viewModel as? CommonCardViewModel else {
            fatalError("DSSpacer received wrong viewModel type")
        }
        
        layer.cornerRadius = vm.style.cornerRadius
        iconImageView.image = vm.backroundImageView
        iconImageView.contentMode = vm.style.contentMode()
        
        let content = viewModel.content
        
        guard contentView != nil else { return }
        
        contentView!.configure(with: content)

        makeConfiguredConstraints(viewModel: viewModel)
    }

    func makeConfiguredConstraints(viewModel: CommonCardViewModel) {
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView!.translatesAutoresizingMaskIntoConstraints = false
        
        applyLayoutToView(layout: vm.content.layout.margin, view: contentView!, topView: nil, botView: nil, superview: self)


        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        if let height = vm.size?.height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

private extension CommonCard {
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }

    @objc func handleTap() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = .identity
            }
        }

        vm.onTap?()
    }
}
