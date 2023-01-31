//
//  ItemReviewsViewModel.swift
//  RecenziRAJ
//
//  Created by Mateo on 29.01.2023..
//

import Foundation

final class ItemReviewsViewModel: BaseViewModel {
    
    var onDidTapAddReview: (() -> Void)?
    var showAlert: ((String?, String?, String?) -> Void)?
    let itemNameEnum: Classifications.ItemName
    
    private let authService: AuthService
    private let userInteractionsService: UserInteractionsService
    private let storageService: StorageService
    private var itemReviews: [ItemReview]?

    init(authService: AuthService,
         userInteractionsService: UserInteractionsService,
         storageService: StorageService,
         itemNameEnum: Classifications.ItemName) {
        self.authService = authService
        self.userInteractionsService = userInteractionsService
        self.storageService = storageService
        self.itemNameEnum = itemNameEnum
    }
    
    func fetchItemReviews(completion: @escaping (([ItemReview], Error?) -> Void)) {
        userInteractionsService.fetchItemReviews(for: itemNameEnum.rawValue) { [weak self] itemReviews, error in
            self?.itemReviews = itemReviews
            completion(itemReviews, error)
        }
    }
    
    func downloadProfileImage(for uid: String?, completion: @escaping ((Data?, Error?) -> Void)) {
        guard let uid = uid else {
            completion(nil, ApiError.LoginError.unknown)
            return
        }
        storageService.downloadProfileImage(uid: uid, completion: completion)
    }
    
    func getItemReviewsTableRowsCount() -> Int {
        itemReviews?.count ?? 0
    }
    
    func getItemReview(at index: Int) -> ItemReview? {
        guard let itemReviews = itemReviews else {
            return nil
        }
        return itemReviews[index]
    }
}
