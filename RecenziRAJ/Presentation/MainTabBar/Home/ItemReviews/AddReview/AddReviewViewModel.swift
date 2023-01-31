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
    private let userInteractionsService: UserInteractionsService

    init(authService: AuthService, userInteractionsService: UserInteractionsService, itemNameEnum: Classifications.ItemName) {
        self.authService = authService
        self.userInteractionsService = userInteractionsService
        self.itemNameEnum = itemNameEnum
    }
    
    func submitReview(review: String, completion: @escaping ((Error?) -> Void)) {
        guard let uid = authService.currentUser?.uid,
              let userDisplayName = authService.currentUser?.displayName else {
            completion((ApiError.LoginError.unknown))
            return
        }
        userInteractionsService.submitItemReview(ItemReview(userUid: uid,
                                                            userDisplayName: userDisplayName,
                                                            itemName: itemNameEnum.rawValue,
                                                            review: review,
                                                            starAmount: 5
                                                           ), completion: completion)
    }
}
