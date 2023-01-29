//
//  ProfileViewModel.swift
//  RecenziRAJ
//
//  Created by Mateo on 08.09.2022..
//

import UIKit
import FirebaseStorage

final class ProfileViewModel: BaseViewModel {
    
    var showAlert: ((String?, String?, String?) -> Void)?
    var onLogoutButtonPressed: (() -> Void)?
    
    private let authService: AuthService
    private let storageService: StorageService
    
    init(authService: AuthService, storageService: StorageService) {
        self.authService = authService
        self.storageService = storageService
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
    
    func uploadProfileImage(_ image: UIImage, completion: @escaping ((StorageMetadata?, Error?) -> Void)) {
        guard let uid = authService.currentUser?.uid else {
            completion(nil, ApiError.LoginError.unknown)
            return
        }
        storageService.uploadProfileImage(uid: uid, image: image, completion: completion)
    }
    
    func downloadProfileImage(completion: @escaping ((Data?, Error?) -> Void)) {
        guard let uid = authService.currentUser?.uid else {
            completion(nil, ApiError.LoginError.unknown)
            return
        }
        storageService.downloadProfileImage(uid: uid, completion: completion)
    }
}

