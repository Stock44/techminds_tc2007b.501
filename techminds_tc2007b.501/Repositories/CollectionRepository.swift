//
//  CollectionRepository.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 07/06/23.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class CollectionRepository : ObservableObject {
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
    
    func createCollection(collection: Collection) async throws {
        guard collection.id == nil else {
            throw RepositoryError.alreadyExists
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        
        let collectionRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection(collectionsPath)
            .document(UUID().uuidString)
        
        
        let snapshot = try await collectionRef.getDocument()
        
        guard !snapshot.exists else {
            throw RepositoryError.alreadyExists
        }
        
        try collectionRef.setData(from: collection)
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
