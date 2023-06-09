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
    let appURL = URL(string: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])!.appending(path: "cardImages")
    private let usersPath = "users"
    private let cardsPath = "cards"
    private let store = Firestore.firestore()
    private let auth = Auth.auth()
    private let cardImageRepository = CardImageRepository()
    
    @Published private(set) var cards: [Card] = []
    
    private var snapshotListenerHandle: ListenerRegistration? = nil
    
    func getCards() throws {
        if let listener = self.snapshotListenerHandle {
            listener.remove()
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        
        let cardsRef = store.collection(usersPath)
            .document(user.uid)
            .collection(cardsPath)
            .order(by: "name")
        
        self.snapshotListenerHandle = cardsRef.addSnapshotListener(self.onCardsChange)

    }
    
    func createCard(card: Card) async throws {
        guard let image = card.image else {
            throw RepositoryError.invalidModel
        }
        guard card.id == nil && card.imageID == nil else {
            throw RepositoryError.alreadyExists
        }
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
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
        
        var newCard = card
        
        newCard.imageID = try await cardImageRepository.addImage(image: image)
        
        try await withCheckedThrowingContinuation{ (continuation: CheckedContinuation<Void, Error>) in
            do {
                try cardRef.setData(from: newCard) { error in
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
            
            if let user = auth.currentUser {
                let cardsRef = store.collection(usersPath)
                    .document(user.uid)
                    .collection(cardsPath)
                    .order(by: "name")
                
                self.snapshotListenerHandle = cardsRef.addSnapshotListener(self.onCardsChange)
            }
            return
        }
        
        guard let user = auth.currentUser else {
            print("no user on cards update")
            return
        }
        
        do {
            self.cards = try snapshot.documents.map { snapshot in
                try snapshot.data(as: Card.self)
            }
        } catch {
            print("error while mapping card documents to Card structs")
        }
    }
}
