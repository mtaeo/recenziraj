//
//  ItemReviewsViewModel.swift
//  RecenziRAJ
//
//  Created by Mateo on 29.01.2023..
//

import Foundation

final class ItemReviewsViewModel: BaseViewModel {
    
    var showAlert: ((String?, String?, String?) -> Void)?
    let itemNameEnum: Classifications.ItemName
    
    private let authService: AuthService

    init(authService: AuthService, itemNameEnum: Classifications.ItemName) {
        self.authService = authService
        self.itemNameEnum = itemNameEnum
    }
}
