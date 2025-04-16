//
//  user registration logic
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

enum UserRegistration {
    // MARK: Use cases
    enum Registration {
        struct Request {
            var form : UserRegistrationRequest
        }

        struct Response {
            var result: UserRegistrationRequestResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    struct UserRegistrationRequest{
        let phoneNumner : String
        let name: String
    }
    
    enum UserRegistrationError: Error {
        case someError(message: String)
    }
    
    enum UserRegistrationRequestResult {
        case failure(UserRegistrationError)
        case success
        case alreadyExists
    }
    
    enum ViewControllerState {
        case loading
        case success
        case alreadyExists
        case error(message: String)
    }
}
