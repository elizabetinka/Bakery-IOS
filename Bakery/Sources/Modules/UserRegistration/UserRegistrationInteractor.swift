//
//  user registration logic
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

protocol UserRegistrationBusinessLogic {
    func registration(request: UserRegistration.Registration.Request)
    func validatePhoneNumber(number: String) -> Bool
    func validateName(name: String) -> Bool
}

/// Класс для описания бизнес-логики модуля UserRegistration
class UserRegistrationInteractor: UserRegistrationBusinessLogic {
    let presenter: UserRegistrationPresentationLogic
    let provider: UserRegistrationProvider

    init(presenter: UserRegistrationPresentationLogic, provider: UserRegistrationProvider = UserRegistrationProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: Registration
    func registration(request: UserRegistration.Registration.Request) {
        
        let addModel = UserModel(uid: undefId, name: request.form.name, points: 0, phoneNumner: request.form.phoneNumner)
        
        provider.registryNewUser(addModel: addModel) { (isSuccess, error) in
            var result: UserRegistration.UserRegistrationRequestResult
            if let error = error {
                switch error {
                case .getUserFailed(_):
                    result = .failure(.someError(message: error.localizedDescription))
                case .alreadyExists:
                    result = .alreadyExists
                case .unknown:
                    result = .failure(.someError(message: "No Data"))
                }
            }
            if isSuccess {
                result = .success
            }
            else {
                result = .failure(.someError(message: "No Data"))
            }
            self.presenter.presentRegistrationResult(response: UserRegistration.Registration.Response(result: result))
        }
        
    }
    
    func validatePhoneNumber(number: String) -> Bool{
        return number.isValidPhone(AppConfig.phoneRegex)
    }
    
    func validateName(name: String) -> Bool{
        return name.isEmpty == false
    }
}
