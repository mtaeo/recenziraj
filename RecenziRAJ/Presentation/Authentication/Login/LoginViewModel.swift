//
//  LoginViewModel.swift
//  RecenziRAJ
//
//  Created by Mateo on 31.08.2022..
//

import Foundation

enum LogInState {
    case idle(isEmailValid: Bool, isPasswordValid: Bool)
    case busy
    case success
    case failure(type: ApiError.LoginError)
}

final class LoginViewModel: BaseViewModel {
    var showAlertWithMessage: ((String?) -> Void)?
    var onStateChange: ((LogInState) -> Void)?
    var onSuccessfullLogin: (() -> Void)?
    var onDidTapRegister: (() -> Void)?
    
    var state: LogInState = .idle(isEmailValid: false, isPasswordValid: false) {
        didSet {
            onStateChange?(state)
        }
    }
    
    var isEmailValid = false {
        didSet {
            state = .idle(isEmailValid: isEmailValid, isPasswordValid: isPasswordValid)
        }
    }
    
    var isPasswordValid = false {
        didSet {
            state = .idle(isEmailValid: isEmailValid, isPasswordValid: isPasswordValid)
        }
    }
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
}

extension LoginViewModel {
    func loginUser(email: String, password: String, onSuccessCompletion: @escaping () -> Void, onErrorCompletion: @escaping (_ error: String?) -> Void) {
        state = .busy
        authService.loginWithEmail(email: email, password: password) { [weak self] error in
            if let error = error {
                self?.state = .failure(type: error)
                onErrorCompletion(error.errorDescription)
            } else {
                self?.state = .success
                onSuccessCompletion()
            }
        }
    }
    
    func validateEmail(_ email: String?) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        isEmailValid = emailPred.evaluate(with: email)
    }
    
    func validatePassword(_ password: String?) {
        guard let password = password else { return }
        isPasswordValid = password.count > 5
    }
}
