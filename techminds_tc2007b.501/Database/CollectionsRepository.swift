//
//  CollectionsRepository.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 06/06/23.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import Combine

class CollectionsRepository : ObservableObject {
    private let usersPath = "users"
    private let collectionsPath = "collections"
    private let store = Firestore.firestore()
    private let auth = Auth.auth()
    
    @Published private(set) var collections: [Collection] = []
    
    private var snapshotListenerHandle: ListenerRegistration? = nil
    
    func getCollections() throws {
        if let listener = self.snapshotListenerHandle {
            listener.remove()
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        
        let collectionsRef = store.collection(usersPath)
            .document(user.uid)
            .collection(collectionsPath)
            .order(by: "name")
        
        self.snapshotListenerHandle = collectionsRef.addSnapshotListener(self.onCollectionsChange)
    }
    
    func createCollection(name: String, color: Color, enabled: Bool) async throws {
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        
        let collectionRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection(collectionsPath)
            .document(UUID().uuidString)
        
        
        let snapshot = try await collectionRef.getDocument()
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            do {
                guard !snapshot.exists else {
                    continuation.resume(throwing: RepositoryError.alreadyExists)
                    return
                }
                
                let newCollection = Collection(name: name, color: CodableColor(cgColor: color.cgColor ?? CGColor(gray: 1.0, alpha: 1.0)), enabled: enabled)
                try collectionRef.setData(from: newCollection) { error in
                    guard error == nil else {
                        continuation.resume(throwing: error!)
                        return
                    }
                    continuation.resume()
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
            
    
    func updateCollection(collection: Collection) async throws{
        guard let collectionId = collection.id else {
            throw RepositoryError.invalidModel
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        
        let collectionRef = store.collection(usersPath).document(user.uid).collection(collectionsPath).document(collectionId)
        try collectionRef.setData(from: collection)
    }
    
    func deleteCollection(collection: Collection) async throws{
        guard let collectionId = collection.id else {
            throw RepositoryError.invalidModel
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        
        let collectionRef = store.collection(usersPath).document(user.uid).collection(collectionsPath).document(collectionId)
        try await collectionRef.delete()
    }
    
    func onCollectionsChange(snapshot: QuerySnapshot?, error: Error?) {
        guard let snapshot = snapshot else {
            print("error getting collections: \(error!)")
            return
        }
        do {
            self.collections = try snapshot.documents.map { snapshot in
                return try snapshot.data(as: Collection.self)
            }
        } catch {
            print("error mapping collections: \(error)")
        }
    }
}
