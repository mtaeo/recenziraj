//
//  StorageService.swift
//  RecenziRAJ
//
//  Created by Mateo on 28.01.2023..
//

import FirebaseStorage

protocol StorageServiceProtocol {
    func uploadProfileImage(uid: String,
                            image: UIImage,
                            completion: @escaping ((StorageMetadata?, Error?) -> Void))
    
    func downloadProfileImage(uid: String,
                              completion: @escaping ((Data?, Error?) -> Void))
}

final class StorageService: StorageServiceProtocol {
    
     let profileImagesStorageRef = Storage.storage().reference().child("profile_images")
    private var imageCache: [String:Data?] = [:]

    func uploadProfileImage(uid: String, image: UIImage, completion: @escaping ((StorageMetadata?, Error?) -> Void)) {
        guard let data = image.pngData() else { return }
        
        profileImagesStorageRef.child(uid).putData(data, metadata: nil) { [weak self] metadata, error in
            if error == nil {
                self?.imageCache[uid] = data
            }
            completion(metadata, error)
        }
    }
    
    func downloadProfileImage(uid: String, completion: @escaping ((Data?, Error?) -> Void)) {
        if let imageDataFromCache = imageCache[uid] {
            completion(imageDataFromCache, nil)
        } else {
            profileImagesStorageRef.child(uid).getData(maxSize: 1 * 3840 * 2160, completion: completion)
        }
    }
}



