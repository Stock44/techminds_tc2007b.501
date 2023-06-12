//
//  UserEditingViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 12/06/23.
//

import Foundation
import Combine
import FirebaseAuth

class UserEditingViewModel: ObservableObject {
    private var userRepository = UserRepository()
    private var userPropertiesRepository = UserPropertiesRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published @MainActor var email: String = ""
    @Published @MainActor var password: String = ""
    @Published @MainActor private(set) var user: User?
    @Published @MainActor var userProperties = UserProperties()
    @Published @MainActor private(set) var error: Error?
    
    @MainActor
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
    
    @MainActor
    func loadCurrent() {
        do {
            try userPropertiesRepository.getUserProperties()
            self.error = nil
        } catch {
            self.error = error
        }
    }
    
    @MainActor
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
    
    @MainActor
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
    
    @MainActor
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
