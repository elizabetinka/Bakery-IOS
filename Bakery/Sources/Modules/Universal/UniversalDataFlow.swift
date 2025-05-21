//
//  Отвечает за универсальный экран для bd ui
//  Created by Елизавета Кравченкова on 20/05/2025.
//

import Foundation

enum Universal {

    enum Init {
        struct Request {
            let config: UniversalScreenConfig
        }

        struct Response {
            var result: UniversalResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    enum Cashe {
        struct Request {
            let config: UniversalScreenConfig
        }

        struct Response {
            var result: UniversalResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    
    enum UniversalResult {
        case failure(message: String)
        case success(data: Data)
    }
    
    enum ViewControllerState {
        case initial
        case setup(model: UniversalViewModel)
    }

}
