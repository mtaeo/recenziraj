//
//  RegisterViewModel.swift
//  RecenziRAJ
//
//  Created by Mateo on 27.08.2022..
//

import Foundation

enum State {
    case idle(isEmailValid: Bool, isPasswordValid: Bool, isRepeatPasswordValid: Bool)
    case busy
    case success
    case failure(type: ApiError.RegisterError)
}

final class RegisterViewModel: BaseViewModel {
    
    var onStateChange: ((State) -> Void)?
    var onDidTapLogin: (() -> Void)?
    
    var state: State = .idle(isEmailValid: false, isPasswordValid: false, isRepeatPasswordValid: false) {
        didSet {
            onStateChange?(state)
        }
    }
    
    var isEmailValid = false {
        didSet {
            state = .idle(isEmailValid: isEmailValid, isPasswordValid: isPasswordValid, isRepeatPasswordValid: isRepeatPasswordValid)
        }
    }
    
    var isPasswordValid = false {
        didSet {
            state = .idle(isEmailValid: isEmailValid, isPasswordValid: isPasswordValid, isRepeatPasswordValid: isRepeatPasswordValid)
        }
    }
    
    var isRepeatPasswordValid = false {
        didSet {
            state = .idle(isEmailValid: isEmailValid, isPasswordValid: isPasswordValid, isRepeatPasswordValid: isRepeatPasswordValid)
        }
    }
    
    var showAlertWithMessage: ((String?) -> Void)?
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
}

extension RegisterViewModel {
    func registerUser(email: String, password: String, onSuccessCompletion: @escaping () -> Void, onErrorCompletion: @escaping (_ error: String?) -> Void) {
        state = .busy
        authService.registerUser(email: email, password: password) { [weak self] error in
            if let error = error {
                self?.state = .failure(type: error)
                onErrorCompletion(error.errorDescription)
            } else {
                self?.state = .success
                onSuccessCompletion()
            }
        }
    }
    
    func validateEmail(email: String?) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        isEmailValid = emailPred.evaluate(with: email)
    }
    
    func validatePassword(password: String?) {
        guard let password = password else { return }
        isPasswordValid = password.count > 5
    }
    
    func validateRepeatPassword(password: String?, repeatPassword: String?) {
        isRepeatPasswordValid = password == repeatPassword
    }
}
