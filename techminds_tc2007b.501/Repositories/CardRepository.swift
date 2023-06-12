//
//  CardsRepository.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 06/06/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class CardRepository : ObservableObject {
    private let usersPath = "users"
    private let cardsPath = "cards"
    private let collectionsPath = "collections"
    private let store = Firestore.firestore()
    private let auth = Auth.auth()
    
    @Published private(set) var cards = Set<Card>()
    
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
        
        cards = Set()
    }
    
    func getCardsForCollectionOnce(collection: Collection) async throws -> Set<Card> {
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        guard let collectionId = collection.id else {
            throw RepositoryError.missingModelID
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
        
        print("loaded \(snapshot.documents.count) cards for collection")
        return Set(try snapshot.documents.map {
            try $0.data(as: Card.self)
        })
    }
    
    func getCardsForCollection(collection: Collection) throws {
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        guard let collectionId = collection.id else {
            throw RepositoryError.missingModelID
        }
        
        reset()
        
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
        
        self.listener = cardsRef.addSnapshotListener(self.onCardsChange)
    }
                                  
    
    func getCards() throws {
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        reset()
        
        let cardsRef = store.collection(usersPath)
            .document(user.uid)
            .collection(cardsPath)
            .order(by: "name")
        
        self.listener = cardsRef.addSnapshotListener(self.onCardsChange)
    }
    
    func createCard(card: Card) async throws {
        guard card.id == nil else {
            throw RepositoryError.alreadyExists
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        let cardID = UUID()
        
        let cardRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection(cardsPath)
            .document(cardID.uuidString)
        
        let snapshot = try await cardRef.getDocument()
        guard !snapshot.exists else {
            // statistically, extremely unlikely. should add a check later though
            throw RepositoryError.alreadyExists
        }
        
        try await withCheckedThrowingContinuation{ (continuation: CheckedContinuation<Void, Error>) in
            do {
                try cardRef.setData(from: card) { error in
                    guard let error = error else {
                        print("saved")
                        continuation.resume()
                        return
                    }
                    continuation.resume(throwing: error)
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    func setCollectionsForCard(card: Card, collections: Set<Collection>) async throws {
        guard let cardId = card.id else {
            throw RepositoryError.missingModelID
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        let cardRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection(cardsPath)
            .document(cardId)
        
        var oldCard = try await cardRef.getDocument(as: Card.self)
        let newCollections = Set(try collections.map {
            guard let collectionId = $0.id else {
                throw RepositoryError.invalidModel
            }
            return store
                .collection(usersPath)
                .document(user.uid)
                .collection(collectionsPath)
                .document(collectionId)
        })
        
        let removedCollections = oldCard.collections.subtracting(newCollections)
        let addedCollections = newCollections.subtracting(oldCard.collections)
        
        print("added \(addedCollections.count)")
        print("removed \(removedCollections.count)")
        
        for collectionDoc in removedCollections {
            var collection = try await collectionDoc.getDocument(as: Collection.self)
            collection.cards.remove(cardRef)
            try collectionDoc.setData(from: collection)
        }
        
        for collectionDoc in addedCollections {
            var collection = try await collectionDoc.getDocument(as: Collection.self)
            collection.cards.insert(cardRef)
            try collectionDoc.setData(from: collection)
        }
        
        
        oldCard.collections = newCollections
        try cardRef.setData(from: oldCard)
    }
    
    func updateCard(card: Card) async throws {
        guard let cardId = card.id else {
            throw RepositoryError.missingModelID
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        let cardRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection(cardsPath)
            .document(cardId)
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            do {
                try cardRef.setData(from: card) { error in
                    guard let error = error else {
                        continuation.resume()
                        return
                    }
                    continuation.resume(throwing: error)
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    func deleteCard(card: Card) async throws{
        guard let cardId = card.id else {
            throw RepositoryError.missingModelID
        }
        
        guard let user = auth.currentUser else {
            throw  RepositoryError.unauthenticated
        }
        
        let cardRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection(cardsPath)
            .document(cardId)
        
        try await cardRef.delete()
    }
    
    func onCardsChange(snapshot: QuerySnapshot?, error: Error?) {
        guard let snapshot = snapshot else {
            print("error with cards change listener: \(error!)")
            return
        }
        
        do {
            print("received \(snapshot.documents.count) cards")
            self.cards = Set(try snapshot.documents.map { snapshot in
                try snapshot.data(as: Card.self)
            })
        } catch {
            print("error while mapping card documents to Card structs")
        }
    }
}
