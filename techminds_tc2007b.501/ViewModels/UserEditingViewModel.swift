//
//  UserEditingViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 12/06/23.
//

import Foundation
import Combine
import FirebaseAuth

@MainActor
class UserEditingViewModel: ObservableObject {
    private var userRepository = UserRepository()
    private var userPropertiesRepository = UserPropertiesRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published private(set) var user: User?
    @Published var userProperties = UserProperties()
    @Published private(set) var error: Error?
    
    init() {
        userRepository
            .$user
            .assign(to: \.user, on: self)
            .store(in: &cancellables)
        
        userPropertiesRepository
            .$userProperties
            .map {
                $0 ?? UserProperties()
            }
            .assign(to: \.userProperties, on: self)
            .store(in: &cancellables)
    }
    
    func loadCurrent() {
        do {
            try userPropertiesRepository.getUserProperties()
            self.error = nil
        } catch {
            self.error = error
        }
    }
    
    func updateEmail(password: String) {
        guard let email = user?.email else {
            self.error = RepositoryError.unauthenticated
            return
        }
        
        Task {
            do {
                try await userRepository.reauthenticate(email: email, password: password)
                try await userRepository.updateUserEmail(email: self.email)
                self.error = nil
            } catch {
                self.error = error
            }
        }
    }
    
    func updatePassword(password: String) {
        guard let email = user?.email else {
            self.error = RepositoryError.unauthenticated
            return
        }
        
        Task {
            do {
                try await userRepository.reauthenticate(email: email, password: password)
                try await userRepository.updateUserPassword(password: self.password)
                self.error = nil
            } catch {
                print("\(error)")
                self.error = error
            }
        }
    }
    
    func update() {
        Task {
            do {
                try await userPropertiesRepository.setUserProperties(userProperties: userProperties)
                self.error = nil
            } catch {
                self.error = error
            }
        }
    }
}
