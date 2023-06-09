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
    private let store = Firestore.firestore()
    private let auth = Auth.auth()
    
    @Published private(set) var cards = Set<Card>()
    @Published private(set) var collections = Set<Collection>()
    
    private var cardsListener: ListenerRegistration?
    private var collectionsListener: ListenerRegistration?
    
    func getCollectionsForCard(card: Card) throws {
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        
        guard let cardID = card.id else {
            throw RepositoryError.invalidModel
        }
        
        if let listener = collectionsListener {
            listener.remove()
        }
        
        let cardRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection(cardsPath)
            .document(cardID)
        
        let collectionsRef = store.collection(usersPath)
            .document(user.uid)
            .collection("collections")
            .whereField("cards", arrayContains: cardRef)
        
        collectionsListener = collectionsRef.addSnapshotListener(self.onCollectionsChange)
    }
    
    func onCollectionsChange(snapshot: QuerySnapshot?, error: Error?) {
        guard let snapshot = snapshot else {
            print("error with cards change listener: \(error!)")
            return
        }
        
        do {
            self.collections = Set(try snapshot.documents.map { snapshot in
                try snapshot.data(as: Collection.self)
            })
        } catch {
            print("error while mapping card's collections documents to Collection structs")
        }
    }
    
    func getCardsForCollection(collection: Collection) throws {
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        
        guard let collectionId = collection.id else {
            throw RepositoryError.invalidModel
        }
        
        let collectionRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection("collections")
            .document(collectionId)
        
        let cardsRef = store
            .collection(usersPath)
            .document(user.uid)
            .collection("cards")
            .whereField("collections", arrayContains: collectionRef)
        
        self.cardsListener = cardsRef.addSnapshotListener(self.onCardsChange)
    }
                                  
    
    func getCards() throws {
        if let listener = cardsListener {
            listener.remove()
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        
        let cardsRef = store.collection(usersPath)
            .document(user.uid)
            .collection(cardsPath)
            .order(by: "name")
        
        self.cardsListener = cardsRef.addSnapshotListener(self.onCardsChange)
    }
    
    func createCard(card: inout Card) async throws {
        guard card.id == nil else {
            throw RepositoryError.alreadyExists
        }
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        
        print("creating")
        
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
        card.id = cardRef.documentID
    }
    
    func updateCard(card: Card) async throws {
        guard let cardId = card.id else {
            throw RepositoryError.invalidModel
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
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
            throw RepositoryError.invalidModel
        }
        
        guard let user = auth.currentUser else {
            throw  RepositoryError.notAuthenticated
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
