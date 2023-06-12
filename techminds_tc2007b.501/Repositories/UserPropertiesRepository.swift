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

class UserPropertiesRepository: ObservableObject {
    private let path = "users"
    private let store = Firestore.firestore()
    private let auth = Auth.auth()
    
    private var snapshotListener: ListenerRegistration?
    private var authListener: AuthStateDidChangeListenerHandle?
    
    @Published private(set) var userProperties: UserProperties? = nil
    
    init() {
        authListener = auth.addStateDidChangeListener(self.onAuthStateChange)
    }
    
    deinit {
        auth.removeStateDidChangeListener(authListener!)
        
        if let listener = snapshotListener {
            listener.remove()
        }
    }
    
    func getUserProperties() throws {
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        if let listener = snapshotListener {
            listener.remove()
        }
        
        let docRef = store
            .collection(path)
            .document(user.uid)
        snapshotListener = docRef.addSnapshotListener(self.onUserPropertiesChange)
    }
    
    func onAuthStateChange(auth: Auth, user: User?) {
        // remove snapshot listener, in case user logs out
        // otherwise do nothing
        guard user == nil else {
            return
        }
        
        if let listener = snapshotListener {
            listener.remove()
        }
        userProperties = nil
    }
    
    func setUserProperties(userProperties: UserProperties) async throws{
        guard auth.currentUser != nil else {
            throw RepositoryError.unauthenticated
        }
        
        guard let userPropertiesId = userProperties.id else {
            throw RepositoryError.missingModelID
        }
        
        let docRef = store
            .collection(self.path)
            .document(userPropertiesId)
        try docRef.setData(from: userProperties)
    }
    
    private func onUserPropertiesChange(snapshot: DocumentSnapshot?, snapshotError: Error?) {
        guard let snapshot = snapshot else {
            print("error acquiring user properties document: \(snapshotError!)")
            
            if let authUser = auth.currentUser {
                let userRef = store.collection(self.path).document(authUser.uid)
                snapshotListener = userRef.addSnapshotListener(self.onUserPropertiesChange)
            }
            return
        }
        // in theory, all users have their respective document created at startup, but
        // in case that isn't true, this check gives them a default document
        do {
            if snapshot.exists {
                userProperties = try snapshot.data(as: UserProperties.self)
            } else {
                let newProperties = UserProperties(name: "", surname: "")
                try snapshot.reference.setData(from: newProperties)
            }
        } catch {
            print("error unpacking snapshot data into UserProperties object")
        }
        
    }
    
}

