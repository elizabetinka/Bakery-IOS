//
//  user registration logic
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

enum UserRegistration {
    
    enum Init {
        struct Request {
        }

        struct Response {
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    enum Loading {
        struct Request {
        }

        struct Response {
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    enum Reload {
        struct Request {
        }

        struct Response {
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    enum ValidateName {
        struct Request {
            var name : String
        }

        struct Response {
            var result: UserRegistrationValidateResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
    enum ValidatePhone {
        struct Request {
            var phone : String
        }

        struct Response {
            var result: UserRegistrationValidateResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }
    
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
    
    enum UserRegistrationRequestResult {
        case failure(message: String)
        case success
        case alreadyExists
    }
    
    enum UserRegistrationValidateResult {
        case failure(message: String)
        case success
    }
    
    enum ViewControllerState {
        case initial
        case success
        case setup(model: UserRegistrationViewModel)
        case configure(model: UserRegistrationViewModel)
    }
}
