//
//  HomeViewModel.swift
//  RecenziRAJ
//
//  Created by Mateo on 08.09.2022..
//

import Foundation

final class HomeViewModel: BaseViewModel {
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
}
