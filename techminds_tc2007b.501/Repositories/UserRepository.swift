//
//  AuthRepository.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 11/06/23.
//

import Foundation
import FirebaseAuth


class UserRepository: ObservableObject {
    private let auth = Auth.auth()
    
    private var listener: AuthStateDidChangeListenerHandle?
    
    @Published private(set) var user: User?
    
    init() {
        listener = auth.addStateDidChangeListener(self.onAuthStateChange)
    }
    
    deinit{
        auth.removeStateDidChangeListener(listener!)
    }
    
    private func onAuthStateChange(auth: Auth, newUser: User?) {
        self.user = newUser
        
        guard let user = self.user else {
            return
        }
    }
    
    func signIn(email: String, password: String) async throws{
        try await self.auth.signIn(withEmail: email, password: password)
    }
    
    func reauthenticate(email: String, password: String) async throws {
        guard let user = auth.currentUser else {
            throw RepositoryError.unauthenticated
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        try await user.reauthenticate(with: credential)
    }
    
    func register(email: String, password: String) async throws{
        try await self.auth.createUser(withEmail: email, password: password)
    }
    
    func signOut() throws {
        try self.auth.signOut()
    }
    
    func updateUserEmail(email: String) async throws{
        guard let user = user else {
            throw RepositoryError.unauthenticated
        }
        
        try await user.updateEmail(to: email)
    }
    
    func updateUserPassword(password: String) async throws {
        guard let user = user else {
            throw RepositoryError.unauthenticated
        }
        
        try await user.updatePassword(to: password)
    }
}
