//
//  AddReviewViewModel.swift
//  RecenziRAJ
//
//  Created by Mateo on 30.01.2023..
//

final class AddReviewViewModel: BaseViewModel {
    
    var showAlert: ((String?, String?, String?) -> Void)?
    let itemNameEnum: Classifications.ItemName
    
    private let authService: AuthService

    init(authService: AuthService, itemNameEnum: Classifications.ItemName) {
        self.authService = authService
        self.itemNameEnum = itemNameEnum
    }
}
