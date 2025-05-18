//
//  Untitled.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 07.05.2025.
//

import UIKit

func applyLayoutToView(layout: DSLayoutMarging, view: UIView, topView: UIView?, botView: UIView?, superview: UIView){
    let all = superview.constraints.filter {
        $0.firstItem === view
    }
    NSLayoutConstraint.deactivate(all)
    
    if case .fill = layout.width,  let mrg = layout.leftMargin {
        view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: mrg).isActive = true
    }
    if case .fill = layout.width,  let mrg = layout.rightMargin {
        view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -mrg).isActive = true
    }
    if case let .fixed(width) = layout.width {
        view.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    if case let .fixed(height) = layout.height {
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    if layout.hAlign == .center {
        view.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    }
    if layout.vAlign == .center {
        view.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    if let mrg = layout.topMargin {
        if let topView = topView {
            view.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: mrg).isActive = true
        }
        else{
            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: mrg).isActive = true
        }
    }
    if let mrg = layout.bottomMargin {
        if let botView = botView {
            botView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: mrg).isActive = true
        }
        else{
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -mrg).isActive = true
        }
    }

}
