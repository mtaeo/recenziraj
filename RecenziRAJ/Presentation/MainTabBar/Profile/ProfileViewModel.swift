//
//  ProfileViewModel.swift
//  RecenziRAJ
//
//  Created by Mateo on 08.09.2022..
//

import Foundation

final class ProfileViewModel: BaseViewModel {
    
    var onLogoutButtonPressed: (() -> Void)?
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
}

