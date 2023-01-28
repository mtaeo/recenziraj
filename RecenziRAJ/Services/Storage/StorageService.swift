//
//  StorageService.swift
//  RecenziRAJ
//
//  Created by Mateo on 28.01.2023..
//

import FirebaseStorage


protocol StorageServiceProtocol {
    
}

final class StorageService: StorageServiceProtocol {
    
    let userProfileImageRef = Storage.storage().reference()
    
    private let storage = Storage.storage()
    
}



