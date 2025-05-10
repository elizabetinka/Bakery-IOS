//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

extension UserView {
    
    func createContentView(nameTextLabel: UIView, phoneTextLabel: UIView, bonusCard: UIView, statusCard: UIView) -> UIView{
        let view = UIView()
        
        view.addSubview(nameTextLabel)
        view.addSubview(phoneTextLabel)
        
        let stack = UIStackView(arrangedSubviews: [bonusCard, statusCard])
        
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(stack)
        
        nameTextLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneTextLabel.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           
//            nameTextLabel.topAnchor.constraint(equalTo: view.topAnchor),
//            nameTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:15),
//            nameTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -15),
//            
//            phoneTextLabel.topAnchor.constraint(equalTo: nameTextLabel.bottomAnchor, constant: 30),
//            phoneTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:15),
//            phoneTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -15),
            
            stack.topAnchor.constraint(equalTo: phoneTextLabel.bottomAnchor, constant: 50),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            stack.heightAnchor.constraint(equalToConstant: 120)
    
        ])
        
        
        return view
    }
}

