//
//  ProfileViewModel.swift
//  RecenziRAJ
//
//  Created by Mateo on 08.09.2022..
//

import Foundation

final class ProfileViewModel: BaseViewModel {
    
    var showAlert: ((String?, String?, String?) -> Void)?
    var onLogoutButtonPressed: (() -> Void)?
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func getUserEmail() -> String? {
        authService.currentUser?.email
    }
    
    func getUserDisplayName() -> String? {
        authService.currentUser?.displayName
    }
    
    func isUserVerified() -> Bool {
        authService.currentUser?.isEmailVerified ?? false
    }
    
    func updateDisplayName(username: String?, completion: @escaping (Error?) -> Void) {
        guard let username = username else {
            return
        }
        authService.updateDisplayName(username: username, completion: completion)
    }
    
    func sendAccountVerification() {
        authService.currentUser?.sendEmailVerification()
    }
    
    func reloadCurrentUser(completion: ((Error?) -> Void)? = nil) {
        authService.currentUser?.reload(completion: completion)
    }
}

