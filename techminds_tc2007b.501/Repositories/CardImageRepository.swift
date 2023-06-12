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
    let cardImagesPath =  "cardImages"
    private let auth = Auth.auth()
    private let storage = Storage.storage()
    
    @Published private(set) var images: [UUID: UIImage] = [:]
    
    func getCardImagesURL() throws -> URL {
        let imagesURL = try FileManager.default.url(for: .picturesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appending(path: "cardImages")
        try FileManager.default.createDirectory(atPath: imagesURL.path(), withIntermediateDirectories: true)
        return imagesURL
    }
    
    func addImage(image: UIImage) async throws -> UUID {
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        let imageID = UUID()
        let imageFileName = "\(imageID.uuidString).jpeg"
        let imageURL = try getCardImagesURL().appending(path: imageFileName)
        
        guard !FileManager.default.fileExists(atPath: imageURL.path()) else {
            throw RepositoryError.alreadyExists
        }
        
        let data = image.jpegData(compressionQuality: 1.0)
        guard let data = data else {
            throw RepositoryError.creationError
        }
        
        guard FileManager.default.createFile(atPath: imageURL.path(), contents: data) else {
            throw RepositoryError.creationError
        }
        
        let cloudFileRef = storage
            .reference()
            .child(user.uid)
            .child(cardImagesPath)
            .child(imageFileName)
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            _ = cloudFileRef.putData(data) { metadata, error in
                guard metadata != nil else {
                    continuation.resume(throwing: error!)
                    return
                }
                
                continuation.resume()
            }
        }
        
        return imageID
    }
    
    func updateImage(imageID: UUID, image: UIImage) async throws {
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        let imageFileName = "\(imageID.uuidString).jpeg"
        let imageURL = try getCardImagesURL().appending(path: imageFileName)
        
        let data = image.jpegData(compressionQuality: 1.0)
        
        guard let data = data else {
            throw RepositoryError.creationError
        }
        
        guard FileManager.default.createFile(atPath: imageURL.path(), contents: data) else {
            throw RepositoryError.creationError
        }
        
        let cloudFileRef = storage
            .reference()
            .child(user.uid)
            .child(cardImagesPath)
            .child(imageFileName)
        
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            _ = cloudFileRef.putFile(from: imageURL) { metadata, error in
                guard metadata != nil else {
                    continuation.resume(throwing: error!)
                    return
                }
                
                continuation.resume()
                
            }
        }
        images[imageID] = image
    }
    
    func getImage(imageID: UUID) async throws -> UIImage{
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        let imageFileName = "\(imageID.uuidString).jpeg"
        let imageFolder = try getCardImagesURL()
        let imageURL = imageFolder.appending(path: imageFileName)
        
        var imageData = FileManager.default.contents(atPath: imageURL.path())
        
        if imageData == nil {
            let cloudFileRef = storage
                .reference()
                .child(user.uid)
                .child(cardImagesPath)
                .child(imageFileName)
            
            let data = try await withCheckedThrowingContinuation { ( continuation: CheckedContinuation<Data, Error> ) in
                _ = cloudFileRef.getData(maxSize: 20 * 1024 * 1024) { data, error in
                    guard let data = data else {
                        continuation.resume(throwing: error!)
                        return
                    }
                    continuation.resume(returning: data)
                }
            }
            
            guard FileManager.default.createFile(atPath: imageURL.path(), contents: data) else {
                throw RepositoryError.creationError
            }
            
            imageData = data
        }
        
        guard let imageData = imageData else {
            throw RepositoryError.retrievalFailure
        }
        
        let image = UIImage(data: imageData)
        guard let image = image else {
            throw RepositoryError.retrievalFailure
        }
        
        DispatchQueue.main.async {
            self.images[imageID] = image
        }
        return image
    }
    
    func deleteImage(imageID: UUID) async throws {
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        let imageFileName = "\(imageID.uuidString).jpeg"
        let imageURL = try getCardImagesURL().appending(path: imageFileName)
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
