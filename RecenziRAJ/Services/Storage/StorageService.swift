//
//  StorageService.swift
//  RecenziRAJ
//
//  Created by Mateo on 28.01.2023..
//

import FirebaseStorage

protocol StorageServiceProtocol {
    func uploadProfileImage(uid: String, image: UIImage, completion: @escaping ((StorageMetadata?, Error?) -> Void))
    func downloadProfileImage(uid: String, completion: @escaping ((Data?, Error?) -> Void))
}

final class StorageService: StorageServiceProtocol {
    
    private let profileImagesStorageRef = Storage.storage().reference().child("profile_images")
        
    func uploadProfileImage(uid: String, image: UIImage, completion: @escaping ((StorageMetadata?, Error?) -> Void)) {
        guard let data = image.pngData() else { return }
        profileImagesStorageRef.child(uid).putData(data, metadata: nil, completion: completion)
    }
    
    func downloadProfileImage(uid: String, completion: @escaping ((Data?, Error?) -> Void)) {
        profileImagesStorageRef.child(uid).getData(maxSize: 1 * 3840 * 2160, completion: completion)
    }
}



