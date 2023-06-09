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

class UserRepository: ObservableObject {
    private let path = "users"
    private let store = Firestore.firestore()
    private let auth = Auth.auth()
    
    @Published private(set) var authUser: FirebaseAuth.User? = nil
    @Published private(set) var user: User? = nil
    
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
            user = nil
            return
        }
        
        let userRef = store.collection(self.path).document(authUser.uid)
        
        if let snapshotListenerHandle = snapshotListenerHandle {
            snapshotListenerHandle.remove()
        }
        
        
        snapshotListenerHandle = userRef.addSnapshotListener(self.onDocumentSnapshotChange)
    }
    
    func signIn(email: String, password: String) async throws{
        try await self.auth.signIn(withEmail: email, password: password)
    }
    
    func register(name: String, surname: String, email: String, password: String) async throws{
        let result = try await self.auth.createUser(withEmail: email, password: password)
        
        let userRef = store.collection(self.path).document(result.user.uid)
        
        let newUser = User(name: name, surname: surname)
        try userRef.setData(from: newUser)
    }
    
    func signOut() throws {
        try self.auth.signOut()
        self.user = nil
        self.authUser = nil
    }
    
    func updateUser(name: String, surname: String, email: String, password: String) async throws{
        guard let authUser = authUser else {
            throw RepositoryError.notAuthenticated
        }
        
        guard let user = user else {
            throw RepositoryError.notAuthenticated
        }
        
        //try await user.updateEmail(to: email)
        //try await user.updatePassword(to: email)
        
       let userRef = store.collection(self.path).document(authUser.uid)
        let newInfo = User(name: name, surname: surname)
       // try userRef.setData(from: newInfo)
    }
    
    private func onDocumentSnapshotChange(snapshot: DocumentSnapshot?, snapshotError: Error?) {
        guard let snapshot = snapshot else {
            print("error acquiring user document: \(snapshotError!)")
            
            if let authUser = auth.currentUser {
                let userRef = store.collection(self.path).document(authUser.uid)
                snapshotListenerHandle = userRef.addSnapshotListener(self.onDocumentSnapshotChange)
            }
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
            print("error unpacking snapshot data into User object")
        }
        
    }
    
}

enum RepositoryError: Error {
    case retrievalFailure
    case notAuthenticated
    case alreadyExists
    case doesNotExist
    case invalidModel
    case creationError
}
