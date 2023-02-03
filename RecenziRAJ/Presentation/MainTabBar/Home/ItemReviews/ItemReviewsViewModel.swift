//
//  ItemReviewsViewModel.swift
//  RecenziRAJ
//
//  Created by Mateo on 29.01.2023..
//

import FirebaseStorage

final class ItemReviewsViewModel: BaseViewModel {
    
    var onDidTapAddReview: (() -> Void)?
    var showAlert: ((String?, String?, String?) -> Void)?
    let itemNameEnum: Classifications.ItemName
    var averageRating: Double = 1
    
    private let authService: AuthService
    private let userInteractionsService: UserInteractionsService
    private let storageService: StorageService
    private var itemReviews: [ItemReview]? {
        didSet {
            calculateAverageRating()
        }
    }

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
    
    func getProfileImageStorageRef(for uid: String?) -> StorageReference {
        storageService.profileImagesStorageRef.child(uid ?? "")
    }
    
    func getItemReview(at index: Int) -> ItemReview? {
        guard let itemReviews = itemReviews else {
            return nil
        }
        return itemReviews[index]
    }
}

private extension ItemReviewsViewModel {
    func calculateAverageRating() {
        let sum = itemReviews?.reduce(0, { partialResult, itemReview in
        partialResult + itemReview.starAmount
        }) ?? 0
        averageRating = itemReviews?.count == 0
                                        ? Double(sum)
                                        : Double(sum / (itemReviews?.count ?? 1))
    }
}
