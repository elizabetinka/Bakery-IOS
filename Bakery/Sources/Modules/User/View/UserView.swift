//
//  Created by Елизавета Кравченкова on 09/04/2025.
//

import UIKit

extension UserView {
    struct Appearance {
        let exampleOffset: CGFloat = 10
        let backgroundColor = UIColor.blue
    }
}

class UserView: UIView {
    let appearance = Appearance()

    fileprivate(set) lazy var customView: UIView = {
        let view = UIView()
        print("create view")
        return view
    }()

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
        addSubview(customView)
    }

    func makeConstraints() {
    }
    
    func showLoading() {
    }

    func showError(message: String) {
    }
    
    func presentUserInfo(userInfo : UserInfoViewModel){}
}
