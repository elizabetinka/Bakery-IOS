//
//  user registration logic
//  Created by Elizaveta Kravchenkova on 15/04/2025.
//

protocol UserRegistrationBusinessLogic {
    func registration(request: UserRegistration.Registration.Request) async
//    func validatePhoneNumber(number: String) -> Bool
//    func validateName(name: String) -> Bool
    
    @MainActor  func initRequest(request: UserRegistration.Init.Request)
    @MainActor  func loadingRequest(request: UserRegistration.Loading.Request)
    @MainActor  func reloadRequest(request: UserRegistration.Reload.Request)
    @MainActor  func validateName(request: UserRegistration.ValidateName.Request)
    @MainActor  func validatePhone(request: UserRegistration.ValidatePhone.Request)
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
    func registration(request: UserRegistration.Registration.Request) async {
        var result: UserRegistration.UserRegistrationRequestResult
        
        let phoneResult =  validatePhoneNumber(number: request.form.phoneNumner)
        let nameResult = validateName(name: request.form.name)
        
        
        if case let .failure(message: error) = phoneResult {
            result = .failure(message: error)
            await self.presenter.presentRegistrationResult(response: UserRegistration.Registration.Response(result: result))
            return
        }
        
        if case let .failure(message: error) = nameResult {
            result = .failure(message: error)
            await self.presenter.presentRegistrationResult(response: UserRegistration.Registration.Response(result: result))
            return
        }
       
        let addModel = UserModel(uid: undefId, name: request.form.name, points: 0, phoneNumber: request.form.phoneNumner)
        
        let (isSuccess, error) = await provider.registryNewUser(addModel: addModel)
        
        
        if let error = error {
            switch error {
            case .getUserFailed(_):
                result = .failure(message: error.localizedDescription)
            case .alreadyExists:
                result = .alreadyExists
            case .unknown:
                result = .failure(message: "No Data")
            }
        }
        else if isSuccess {
            result = .success
        }
        else {
            result = .failure(message: "No Data")
        }
        await self.presenter.presentRegistrationResult(response: UserRegistration.Registration.Response(result: result))
    }
    
    @MainActor func initRequest(request: UserRegistration.Init.Request) {
        presenter.presentInitialData(response: UserRegistration.Init.Response())
    }
    
    @MainActor func loadingRequest(request: UserRegistration.Loading.Request) {
        presenter.presentLoadingData(response: UserRegistration.Loading.Response())
    }
    
    func reloadRequest(request: UserRegistration.Reload.Request) {
        presenter.presentReloadData(response: UserRegistration.Reload.Response())
    }
            
    
    @MainActor func validateName(request: UserRegistration.ValidateName.Request){
        
        var nameResult = validateName(name: request.name)
    
        self.presenter.presentValidatedName(response:  UserRegistration.ValidateName.Response(result: nameResult))
    }
    
    
    @MainActor func validatePhone(request: UserRegistration.ValidatePhone.Request){
        
        var phoneResult =  validatePhoneNumber(number: request.phone)
        
        self.presenter.presentValidatedPhone(response:  UserRegistration.ValidatePhone.Response(result: phoneResult))
    }
    
    private func validatePhoneNumber(number: String) -> UserRegistration.UserRegistrationValidateResult {
        var phoneResult: UserRegistration.UserRegistrationValidateResult = .success
         
         if number.isEmpty {
             phoneResult = .failure(message: "Введите номер телефона")
         }
         else if (!number.isValidPhone(AppConfig.phoneRegex)){
             phoneResult = .failure(message: "Неккоректный формат")
         }
        return phoneResult
    }
    
    private func validateName(name: String) -> UserRegistration.UserRegistrationValidateResult{
        
        var nameResult: UserRegistration.UserRegistrationValidateResult = .success
        
        if name.isEmpty {
            nameResult = .failure(message: "Введите имя")
        }
        
        return nameResult
    }
}
