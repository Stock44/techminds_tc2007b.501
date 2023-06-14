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
    
    func updateEmail(password: String) async throws {
        guard let email = await user?.email else {
            throw RepositoryError.unauthenticated
        }
        try await userRepository.reauthenticate(email: email, password: password)
        try await userRepository.updateUserEmail(email: self.email)
    }
    
    func updatePassword(password: String) async throws {
        guard let email = await user?.email else {
            throw RepositoryError.unauthenticated
        }
        
        try await userRepository.reauthenticate(email: email, password: password)
        try await userRepository.updateUserPassword(password: self.password)
    }
    
    func update() async throws{
        try await userPropertiesRepository.setUserProperties(userProperties: userProperties)
    }
}
