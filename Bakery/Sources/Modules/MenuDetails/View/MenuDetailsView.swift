//
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

import UIKit

extension MenuDetailsView {
    struct Appearance {
        let exampleOffset: CGFloat = 10
        let backgroundColor: UIColor = .systemBackground
        let labelFont = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
}

class MenuDetailsView: UIView {
    let appearance = Appearance()

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        
        backgroundColor=appearance.backgroundColor
        
        addSubviews()
        makeConstraints()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews(){
        
    }

    func makeConstraints() {
    }
    
    func showLoading() {}
    
    func showError(message: String) {}
    
    func updateData(details: MenuDetailsViewModel) {}
    
    func showEmptyView(){}
}
