//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

@MainActor
extension MenuDetailsView {
    
    func createContentView(imageView: UIImageView, titleLabel: UILabel, descriptionLabel: UILabel) -> UIView {
        let view = UIView()
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor,constant: -50),

           
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-15),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-15),
        ])
        
        
        return view
    }
}
