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

class CardsRepository : ObservableObject {
    let appURL = URL(string: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])!.appending(path: "cardImages")
    private let usersPath = "users"
    private let cardsPath = "cards"
    private let store = Firestore.firestore()
    private let auth = Auth.auth()
    private let storage = Storage.storage()
    
    @Published private(set) var cards: [Card] = []
    
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
            return
        }
        
        let cardsRef = store.collection(usersPath)
            .document(user.uid)
            .collection(cardsPath)
            .order(by: "name")
        
        self.snapshotListenerHandle = cardsRef.addSnapshotListener(self.onCardsChange)
    }
    
    func createCard(name: String, image: UIImage) async throws {
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        
        let cardDocumentName = UUID().uuidString
        let imageFileName = "\(cardDocumentName).jpeg"
        let imageURL = appURL.appending(path: imageFileName)
        
        guard !FileManager.default.fileExists(atPath: imageURL.path()) else {
            throw RepositoryError.alreadyExists
        }
        
        FileManager.default.createFile(atPath: imageURL.path(), contents: image.jpegData(compressionQuality: 1.0))
        
        let cloudFileRef = storage.reference().child("images").child(user.uid).child(imageFileName)
        
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
        
        let cardRef = store.collection(usersPath).document(user.uid).collection(cardsPath).document(cardDocumentName)
        
        let snapshot = try await cardRef.getDocument()
        guard !snapshot.exists else {
            throw RepositoryError.alreadyExists
        }
        
        let newCard = Card(name: name, imageURL: imageURL)
        
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
    
    func updateCardImage(card: Card, image: UIImage) async throws {
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        
        guard let cardId = card.id else {
            throw RepositoryError.invalidModel
        }
        
        let imageFileName = "\(cardId).jpeg"
        let imageURL = appURL.appending(path: imageFileName)
        
        FileManager.default.createFile(atPath: imageURL.path(), contents: image.jpegData(compressionQuality: 0.8))
        
        let cloudFileRef = storage.reference().child("images").child(user.uid).child(imageFileName)
        
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
    }
    
    func updateCard(card: Card) async throws {
        guard let cardId = card.id else {
            throw RepositoryError.invalidModel
        }
        
        guard let user = auth.currentUser else {
            throw RepositoryError.notAuthenticated
        }
        
        let cardRef = store.collection(usersPath).document(user.uid).collection(cardsPath).document(cardId)
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
        
        let cardRef = store.collection(usersPath).document(user.uid).collection(cardsPath).document(cardId)
        try await cardRef.delete()
        
        let cardDocumentName = UUID().uuidString
        let imageFileName = "\(cardDocumentName).jpeg"
        let imageURL = appURL.appending(path: imageFileName)
        
        try FileManager.default.removeItem(atPath: imageURL.path())
        let cardImgRef = storage.reference().child("images").child(user.uid).child(imageFileName)
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
            self.cards = try snapshot.documents.enumerated().map { idx, snapshot in
                let card = try snapshot.data(as: Card.self)
                
                let imageFileName = "\(card.id!).jpeg"
                let imageURL = appURL.appending(path: imageFileName)
                
                if !FileManager.default.fileExists(atPath: imageURL.path()) {
                    Task {
                        let cloudFileRef = storage.reference().child("images").child(user.uid).child(imageFileName)
                        
                        do {
                            let _ = try await cloudFileRef.writeAsync(toFile: imageURL)
                            self.cards[idx].imageURL = imageURL
                        } catch {
                            print("error while downloading image for card: \(error)")
                        }
                        
                    }
                } else {
                    self.cards[idx].imageURL = imageURL
                }
                
                return card
            }
        } catch {
            print("error while mapping card documents to Card structs")
        }
    }
}
