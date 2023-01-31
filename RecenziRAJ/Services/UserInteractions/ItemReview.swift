//
//  Review.swift
//  RecenziRAJ
//
//  Created by Mateo on 31.01.2023..
//

import Foundation

struct ItemReview {
    let userUid: String
    let userDisplayName: String
    let itemName: String
    let review: String
    let starAmount: Int
}

extension ItemReview: Codable {
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(ItemReview.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
}
    
