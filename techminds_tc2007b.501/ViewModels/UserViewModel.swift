//
//  UserViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 07/06/23.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    private var userRepository = UserRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var user: User?
    @Published var error: Error?
    
    init () {
        userRepository.$user
            .assign(to: \.user, on: self)
            .store(in: &cancellables)
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
    
    func register(name: String, surname: String, email: String, password: String) {
        Task {
            do {
                try await userRepository.register(name: name, surname: surname, email: email, password: password)
                self.error = nil
            } catch  {
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
