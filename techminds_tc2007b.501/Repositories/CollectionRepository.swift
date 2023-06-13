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
    private let cardsPath = "cards"
    private let collectionsPath = "collections"
    private let store = Firestore.firestore()
    private let auth = Auth.auth()
    
    @Published private(set) var collections = Set<Collection>()
    
    private var listener: ListenerRegistration?
    
    deinit {
        if let listener = listener {
            listener.remove()
        }
    }
    
    func reset() {
        if let listener = listener {
            listener.remove()
            self.listener = nil
        }
        
        collections = []
    }
    
    func getCollectionsForCard(card: Card) throws {
        guard let cardID = card.id else {
            throw RepositoryError.missingModelID
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        reset()
        
        let cardRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection(cardsPath)
            .document(cardID)
        
        let collectionsRef = store.collection(usersPath)
            .document(user.uid)
            .collection(collectionsPath)
            .whereField(cardsPath, arrayContains: cardRef)
        
        listener = collectionsRef.addSnapshotListener(self.onCollectionsChange)
    }
    
    func getCollections() throws {
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        reset()
        
        let collectionsRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection(collectionsPath)
        
        listener = collectionsRef.addSnapshotListener(self.onCollectionsChange)
    }
    
    func getCollectionsOnce() async throws {
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        reset()
        
        let collectionsRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection(collectionsPath)
        
        collections = Set(try await collectionsRef
            .getDocuments()
            .documents.map {
                try $0.data(as: Collection.self)
            })
    }
    
    func getCollectionsForCardOnce(card: Card) async throws -> Set<Collection> {
        guard let cardID = card.id else {
            throw RepositoryError.missingModelID
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        let cardRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection(cardsPath)
            .document(cardID)
        
        let collectionsRef = store.collection(usersPath)
            .document(user.uid)
            .collection(collectionsPath)
            .whereField(cardsPath, arrayContains: cardRef)
        
        let snapshot = try await collectionsRef.getDocuments()
        return Set(try snapshot.documents.map {
            try $0.data(as: Collection.self)
        })
    }
    
    func setCardsForCollection(collection: Collection, cards: Set<Card>) async throws {
        guard let collectionId = collection.id else {
            throw RepositoryError.missingModelID
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        let collectionRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection(collectionsPath)
            .document(collectionId)
        
        var oldCollection = try await collectionRef.getDocument(as: Collection.self)
        let newCards = Set(try cards.map {
            guard let cardId = $0.id else {
                throw RepositoryError.invalidModel
            }
            return store
                .collection(usersPath)
                .document(user.uid)
                .collection(cardsPath)
                .document(cardId)
        })
        
        let removedCards = oldCollection.cards.subtracting(newCards)
        let addedCards = newCards.subtracting(oldCollection.cards)
        
        print("added \(addedCards.count)")
        print("removed \(removedCards.count)")
        
        for cardDoc in removedCards {
            var card = try await cardDoc.getDocument(as: Card.self)
            card.collections.remove(collectionRef)
            try cardDoc.setData(from: card)
        }
        
        for cardDoc in addedCards {
            var card = try await cardDoc.getDocument(as: Card.self)
            card.collections.insert(collectionRef)
            try cardDoc.setData(from: card)
        }
        
        
        oldCollection.cards = newCards
        try collectionRef.setData(from: oldCollection)
    }
    
    func createCollection(collection: Collection) async throws {
        guard collection.id == nil else {
            throw RepositoryError.alreadyExists
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
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
            throw RepositoryError.missingModelID
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        let collectionRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection(collectionsPath)
            .document(collectionId)
        try collectionRef.setData(from: collection)
    }
    
    func deleteCollection(collection: Collection) async throws{
        guard let collectionId = collection.id else {
            throw RepositoryError.missingModelID
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        let collectionRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection(collectionsPath)
            .document(collectionId)
        
        let cardsRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection(cardsPath)
            .whereField(collectionsPath, arrayContains: collectionRef)
        
        let snapshot = try await cardsRef.getDocuments()
        
        for cardDoc in snapshot.documents {
            var card = try cardDoc.data(as: Card.self)
            card.collections.remove(collectionRef)
            
            let cardRef = store
                .collection(usersPath)
                .document(user.uid)
                .collection(cardsPath)
                .document(cardDoc.documentID)
            
            try cardRef.setData(from: card)
        }
        
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
