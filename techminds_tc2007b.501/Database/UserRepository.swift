//
//  FirebaseUser.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 05/06/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class UserRepository: ObservableObject {
    private let path = "users"
    private let store = Firestore.firestore()
    private let auth = Auth.auth()
    
    @Published private(set) var authUser: FirebaseAuth.User? = nil
    @Published private(set) var user: User? = nil
    @Published private(set) var error: Error? = nil
    
    private var authStateListenerHandle: AuthStateDidChangeListenerHandle? = nil
    private var snapshotListenerHandle: ListenerRegistration? = nil
    
    init() {
        auth.addStateDidChangeListener(self.onAuthStateChange)
    }
    
    private func onAuthStateChange(auth: Auth, authUser: FirebaseAuth.User?) {
        self.authUser = authUser
        
        guard let authUser = authUser else {
            if let listener = snapshotListenerHandle {
                listener.remove()
            }
            return
        }
        
        let userRef = store.collection(self.path).document(authUser.uid)
        
        if let snapshotListenerHandle = snapshotListenerHandle {
            snapshotListenerHandle.remove()
        }
        
        
        snapshotListenerHandle = userRef.addSnapshotListener(self.onDocumentSnapshotChange)
    }
    
    func signIn(email: String, password: String) {
        Task {
            do {
                try await self.auth.signIn(withEmail: email, password: password)
            } catch {
                self.error = error
            }
        }
        
    }
    
    func register(name: String, surname: String, email: String, password: String) {
        Task {
            do {
                let result = try await self.auth.createUser(withEmail: email, password: password)
                
                let userRef = store.collection(self.path).document(result.user.uid)
                
                let newUser = User(name: name, surname: surname)
                try userRef.setData(from: newUser)
            } catch {
                self.error = error
            }
        }
        
    }
    
    func signOut() throws{
        try self.auth.signOut()
        self.user = nil
        self.authUser = nil
    }
    
    private func onDocumentSnapshotChange(snapshot: DocumentSnapshot?, snapshotError: Error?) {
        guard let snapshot = snapshot else {
            self.error = error
            return
        }
        // in theory, all users have their respective document created at startup, but
        // in case that isn't true, this check gives them a default document
        do {
            if snapshot.exists {
                self.user = try snapshot.data(as: User.self)
            } else {
                let newUser = User(name: "", surname: "")
                try snapshot.reference.setData(from: newUser)
            }
        } catch {
            self.error = error
        }
        
    }
    
}

enum RepositoryError: Error {
    case snapshotRetrievalFailure
    case notAuthenticated
    case alreadyExists
    case invalidModel
}
