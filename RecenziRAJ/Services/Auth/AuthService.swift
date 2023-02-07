//
//  AuthService.swift
//  RecenziRAJ
//
//  Created by Mateo on 28.08.2022..
//

import FirebaseAuth

enum AuthSignUpState {
    case success
    case failure
}

protocol AuthServiceProtocol {
    var currentUser: User? { get }
    var signUpState: AuthSignUpState { get set }
    
    func loginWithEmail(email: String,
                        password: String,
                        completion: @escaping (_ error: ApiError.LoginError?) -> Void)
    
    func registerUser(email: String,
                      password: String,
                      completion: @escaping (_ error: ApiError.RegisterError?) -> Void)
    
    func sendPasswordReset(email: String,
                           _ completion: ((Error?) -> ())?)
    
    func updateDisplayName(username: String,
                           completion: @escaping (Error?) -> Void)
    
    func logoutUser()
}

final class AuthService: AuthServiceProtocol {
    // Detalji implementacije
    
    private let auth = FirebaseAuth.Auth.auth()
    var currentUser: User?
    var signUpState = AuthSignUpState.failure
    
    func loginWithEmail(email: String, password: String, completion: @escaping (ApiError.LoginError?) -> Void) {
        auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
            let loginError: ApiError.LoginError?
            
            if let error = error as NSError? {
                let errorCode = AuthErrorCode(_nsError: error).code
                
                switch errorCode {
                case .invalidEmail:
                    loginError = .invalidEmail
                case .wrongPassword:
                    loginError = .wrongPassword
                case .userDisabled:
                    loginError = .userDisabled
                default:
                    loginError = .unknown
                }
            } else {
                self?.currentUser = self?.auth.currentUser
                loginError = nil
            }
            completion(loginError)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping (ApiError.RegisterError?) -> Void) {
        auth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
            
            let signUpError: ApiError.RegisterError?
            
            if let error = error as NSError? {
                let errorCode = AuthErrorCode(_nsError: error).code
                
                switch errorCode {
                case .emailAlreadyInUse:
                    signUpError = .emailAlreadyInUse
                case .invalidEmail:
                    signUpError = .invalidEmail
                case .weakPassword:
                    signUpError = .weakPassword
                default:
                    signUpError = .unknown
                }
            } else {
                self?.currentUser = self?.auth.currentUser
                self?.currentUser?.sendEmailVerification()
                signUpError = nil
            }
            completion(signUpError)
        }
    }
    
    func sendPasswordReset(email: String, _ completion: ((Error?) -> ())? = nil) {
        auth.sendPasswordReset(withEmail: email, completion: completion)
    }
    
    func updateDisplayName(username: String, completion: @escaping (Error?) -> Void) {
        let changeRequest = auth.currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = username
        changeRequest?.commitChanges { (error) in
          completion(error)
        }
    }
    
    func logoutUser() {
        do {
            try auth.signOut()
            currentUser = nil
        } catch {
            print(error)
        }
    }
}

