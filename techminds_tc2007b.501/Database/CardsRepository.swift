//
//  CardsRepository.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 06/06/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class CardsRepository : ObservableObject {
    private let usersPath = "users"
    private let cardsPath = "cards"
    private let store = Firestore.firestore()
    private let auth = Auth.auth()
    
    @Published private(set) var cards: [Card] = []
    @Published private(set) var error: Error? = nil
    
    private var snapshotListenerHandle: ListenerRegistration? = nil
    private var authStateChangeListenerHandle: AuthStateDidChangeListenerHandle? = nil
    
    init() {
        authStateChangeListenerHandle = auth.addStateDidChangeListener(self.onAuthStateChange)
    }
    
    func onAuthStateChange(auth: Auth, authUser: FirebaseAuth.User?) {
        if let listener = snapshotListenerHandle {
            listener.remove()
        }
        
        guard let user = auth.currentUser else {
            self.error = RepositoryError.notAuthenticated
            return
        }
        
        let cardsRef = store.collection(usersPath)
            .document(user.uid)
            .collection(cardsPath)
            .order(by: "name")
        
        self.snapshotListenerHandle = cardsRef.addSnapshotListener(self.onCardsChange)
    }
    
    func createCard(name: String, imageUrl: String) {
        guard let user = auth.currentUser else {
            self.error = RepositoryError.notAuthenticated
            return
        }
        
        let cardRef = store.collection(usersPath).document(user.uid).collection(cardsPath).document(UUID().uuidString)
        
        Task {
            do {
                let snapshot = try await cardRef.getDocument()
                if snapshot.exists {
                    error = RepositoryError.alreadyExists
                    return
                }
                
                let newCard = Card(name: name, imageURL: imageUrl)
                try cardRef.setData(from: newCard) { error in
                    guard error == nil else {
                        return
                    }
                }
            } catch {
                self.error = error
            }
        }
        
    }
    
    func updateCard(card: Card) {
        guard let cardId = card.id else {
            self.error = RepositoryError.invalidModel
            return
        }
        
        guard let user = auth.currentUser else {
            self.error = RepositoryError.notAuthenticated
            return
        }
        
        let cardRef = store.collection(usersPath).document(user.uid).collection(cardsPath).document(cardId)
        do {
            try cardRef.setData(from: card)
        } catch {
            self.error = error
        }
    }
    
    func deleteCard(card: Card) {
        guard let cardId = card.id else {
            self.error = RepositoryError.invalidModel
            return
        }
        
        guard let user = auth.currentUser else {
            self.error = RepositoryError.notAuthenticated
            return
        }
        
        let cardRef = store.collection(usersPath).document(user.uid).collection(cardsPath).document(cardId)
        Task {
            do {
                try await cardRef.delete()
            } catch {
                self.error = error
            }
        }
    }
    
    func onCardsChange(snapshot: QuerySnapshot?, error: Error?) {
        guard let snapshot = snapshot else {
            self.error = error
            return
        }
        do {
            self.cards = try snapshot.documents.map { snapshot in
                return try snapshot.data(as: Card.self)
            }
        } catch {
            self.error = error
        }
    }
}
