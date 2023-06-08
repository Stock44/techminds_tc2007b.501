//
//  CardImageRepository.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/06/23.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import UIKit

class CardImageRepository: ObservableObject {
    let cardImagesURL = URL(string: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])!.appending(path: "cardImages")
    let cardImagesPath =  "cardImages"
    private let auth = Auth.auth()
    private let storage = Storage.storage()
    
    @Published var images: [UUID: UIImage] = [:]
    
    func addImage(image: UIImage) async throws -> UUID {
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        
        let imageID = UUID()
        let imageFileName = "\(imageID.uuidString).jpeg"
        let imageURL = cardImagesURL.appending(path: imageFileName)
        
        guard !FileManager.default.fileExists(atPath: imageURL.path()) else {
            throw RepositoryError.alreadyExists
        }
       
        FileManager.default.createFile(atPath: imageURL.path(), contents: image.jpegData(compressionQuality: 1.0))
        
        let cloudFileRef = storage
            .reference()
            .child(user.uid)
            .child(cardImagesPath)
            .child(imageFileName)
        
        let fileTask = cloudFileRef.putFile(from: imageURL)
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            fileTask.observe(.success) { snapshot in
                continuation.resume()
            }
            
            fileTask.observe(.failure) { snapshot in
                guard let error = snapshot.error else {
                    return
                }
                continuation.resume(throwing: error)
            }
        }
        
        return imageID
    }
    
    func updateImage(imageID: UUID, image: UIImage) async throws {
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        
        let imageFileName = "\(imageID.uuidString).jpeg"
        let imageURL = cardImagesURL.appending(path: imageFileName)
        
        FileManager.default.createFile(atPath: imageURL.path(), contents: image.jpegData(compressionQuality: 1.0))
        
        let cloudFileRef = storage
            .reference()
            .child(user.uid)
            .child(cardImagesPath)
            .child(imageFileName)
        
        let fileTask = cloudFileRef.putFile(from: imageURL)
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            fileTask.observe(.success) { snapshot in
                continuation.resume()
            }
            
            fileTask.observe(.failure) { snapshot in
                guard let error = snapshot.error else {
                    return
                }
                continuation.resume(throwing: error)
            }
        }
        images[imageID] = image
    }
    
    func getImage(imageID: UUID) async throws {
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        let imageFileName = "\(imageID.uuidString).jpeg"
        let imageURL = cardImagesURL.appending(path: imageFileName)

        let imageData = FileManager.default.contents(atPath: imageURL.path())
        
        if imageData == nil {
            let cloudFileRef = storage
                .reference()
                .child(user.uid)
                .child(cardImagesPath)
                .child(imageFileName)
            
            let snapshot = try await cloudFileRef.writeAsync(toFile: imageURL)
            
            let imageData = FileManager.default.contents(atPath: imageURL.path())
        }
        
        guard let imageData = imageData else {
            throw RepositoryError.retrievalFailure
        }
        
        let image = UIImage(data: imageData)
        guard let image = image else {
            throw RepositoryError.retrievalFailure
        }
        images[imageID] = image
    }
    
    func deleteImage(imageID: UUID) async throws {
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        
        let imageFileName = "\(imageID.uuidString).jpeg"
        let imageURL = cardImagesURL.appending(path: imageFileName)
        let cloudFileRef = storage
            .reference()
            .child(user.uid)
            .child(cardImagesPath)
            .child(imageFileName)
        
        // check if file exists, throws if it doesn't
        let _ = try await cloudFileRef.downloadURL()
        
        try await cloudFileRef.delete()
        try FileManager.default.removeItem(at: imageURL)
        images.removeValue(forKey: imageID)
    }
}
