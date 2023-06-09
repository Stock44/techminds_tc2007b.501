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
    
    @Published private(set) var collections = Set<Collection>()
    @Published private(set) var cards = Set<Card>()
    
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
    
    func addCardsToCollection(collection: Collection, cards: Set<Card>) async throws {
        guard let collectionId = collection.id else {
            throw RepositoryError.invalidModel
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        
        
        let collectionRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection(collectionsPath)
            .document(collectionId)
        
        
        
        for card in cards {
            guard let cardId = card.id else {
                continue
            }
            let cardRef = store
                .collection(usersPath)
                .document(user.uid)
                .collection("cards")
                .document(cardId)
            
            
            var newCard = card
            newCard.collections.insert(collectionRef)
            
            try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
                do {
                    try cardRef.setData(from: newCard) { error in
                        if let error = error {
                            continuation.resume(throwing: error)
                        }
                        continuation.resume()
                    }
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
        
        let cardRefs = Set(cards
            .filter {$0.id != nil}
            .map{
                store
                    .collection(usersPath)
                    .document(user.uid)
                    .collection("cards")
                    .document($0.id!)
            })
        
        var newCollection = collection
        newCollection.cards.formUnion(cardRefs)
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            do {
                try collectionRef.setData(from: newCollection) { error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    }
                    continuation.resume()
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
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
        
        var newCollection = collection
        
        newCollection.cards = Set(try cards.map { card in
            guard let cardId = card.id else {
                throw RepositoryError.invalidModel
            }
            
            return store
                .collection(usersPath)
                .document(user.uid)
                .collection("cards")
                .document(cardId)
        })
        
        
        try collectionRef.setData(from: newCollection)
    }
    
    
    func updateCollection(collection: Collection) async throws{
        guard let collectionId = collection.id else {
            print("no collection id")
            throw RepositoryError.invalidModel
        }
        
        guard let user = auth.currentUser else {
            print("no user")
            throw RepositoryError.notAuthenticated
        }
        
        var newCollection = collection
        
        newCollection.cards = Set(try cards.map { card in
            guard let cardId = card.id else {
                print("no id for this card")
                throw RepositoryError.invalidModel
            }
            
            return store
                .collection(usersPath)
                .document(user.uid)
                .collection("cards")
                .document(cardId)
        })
        
        
        print("updating")
        let collectionRef = store.collection(usersPath).document(user.uid).collection(collectionsPath).document(collectionId)
        try collectionRef.setData(from: newCollection)
        print("updated")
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
            self.collections = Set(try snapshot.documents.map { snapshot in
                return try snapshot.data(as: Collection.self)
            })
        } catch {
            print("error mapping collections: \(error)")
        }
    }
}
