//
//  UserViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 07/06/23.
//

import Foundation
import Combine
import FirebaseAuth

@MainActor
class UserViewModel: ObservableObject {
    private var userRepository = UserRepository()
    private var userPropertiesRepository = UserPropertiesRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published private(set) var user: User?
    @Published private(set) var userProperties: UserProperties?
    @Published private(set) var error: Error?
    
    init () {
        // get properties when received
        userPropertiesRepository
            .$userProperties
            .assign(to: \.userProperties, on: self)
            .store(in: &cancellables)
        
        // get user when logged in
        userRepository
            .$user
            .assign(to: \.user, on: self)
            .store(in: &cancellables)
    }
    
    func getCurrent() {
        do {
            try userPropertiesRepository.getUserProperties()
            self.error = nil
        } catch {
            self.error = error
        }
    }
    
    func signIn(email: String, password: String) {
        Task {
            do {
                try await userRepository.signIn(email: email, password: password)
                self.error = nil
            } catch {
                self.error = error
            }
        }
    }
    
    func signOut() {
        do {
            try userRepository.signOut()
            self.error = nil
        } catch {
            self.error = error
        }
    }
}
