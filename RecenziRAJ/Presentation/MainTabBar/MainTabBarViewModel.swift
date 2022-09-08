//
//  MainTabBarViewModel.swift
//  RecenziRAJ
//
//  Created by Mateo on 06.09.2022..
//

import Foundation

final class MainTabBarViewModel: BaseViewModel {
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
}
