//
//  UserInteractions.swift
//  RecenziRAJ
//
//  Created by Mateo on 31.01.2023..
//

import FirebaseCore
import FirebaseFirestore

protocol UserInteractionsServiceProtocol {
    func submitItemReview(_ itemReview: ItemReview, completion: @escaping ((Error?) -> Void))
    func fetchItemReviews(for itemName: String, completion: @escaping (([ItemReview], Error?) -> Void)) 
}

final class UserInteractionsService: UserInteractionsServiceProtocol {
    
    private let itemReviews = Firestore.firestore().collection("item_reviews")
    
    func submitItemReview(_ itemReview: ItemReview, completion: @escaping ((Error?) -> Void)) {
        itemReviews.document("\(itemReview.userUid)\\\(itemReview.itemName)").setData(itemReview.dictionary, completion: completion)
    }
    
    func fetchItemReviews(for itemName: String, completion: @escaping (([ItemReview], Error?) -> Void)) {
        itemReviews.whereField("itemName", isEqualTo: itemName).getDocuments { snapshot, error in
            if let snapshot = snapshot {
                let itemReviews = snapshot.documents.compactMap { snapshot in
                    try? ItemReview(dictionary: snapshot.data())
                }
                completion(itemReviews, error)
            } else {
                completion([], error)
            }
        }
    }
}
