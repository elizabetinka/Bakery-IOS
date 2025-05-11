//
//  DSButton.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 29.04.2025.
//

import UIKit

final class DSButton : UIView, DSView {
    private var viewModel: DSButtonViewModel?
    private var button = UIButton()
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        let hoverGR = UIHoverGestureRecognizer(target: self, action: #selector(handleHover(_:)))
        
        button.addGestureRecognizer(hoverGR)
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
    }


    func configure(with viewModel: DSViewModel) {
        guard let viewModel = viewModel as? DSButtonViewModel else {
            fatalError("DSSpacer received wrong viewModel type")
        }
        self.viewModel = viewModel
        button.setTitle(viewModel.title, for: .normal)
        button.setTitleColor(viewModel.style.textColor(for: viewModel.state), for: .normal)
        button.titleLabel?.font = viewModel.size.font
        button.backgroundColor = viewModel.style.backgroundColor(for: viewModel.state)
        button.layer.cornerRadius = viewModel.size.cornerRadius
        button.clipsToBounds = viewModel.style.clipsToBounds

        button.heightAnchor.constraint(equalToConstant: viewModel.size.height).isActive = true
        
        button.isEnabled = viewModel.state != .disabled
        
        button.isHidden = viewModel.state == .hidden
        
        makeConfiguredConstraints(viewModel: viewModel)
    }
    
    func makeConfiguredConstraints(viewModel: DSButtonViewModel){
        let layout = viewModel.layout.padding
        
        button.contentEdgeInsets = UIEdgeInsets(top: layout.vPadding, left: layout.hPadding, bottom: layout.vPadding, right: layout.hPadding)
        
        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    @objc private func didTap() {
        guard viewModel?.state != .disabled else { return }
        viewModel?.onTap?()
    }
    
    @objc private func handleHover(_ gr: UIHoverGestureRecognizer) {
        guard var vm = viewModel else { return }
        switch gr.state {
        case .began, .changed:
            vm.state = .hover
        case .ended:
            vm.state = .default
        default: return
        }
        configure(with: vm)
    }
}
