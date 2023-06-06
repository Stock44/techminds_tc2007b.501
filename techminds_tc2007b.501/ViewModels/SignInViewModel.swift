//
//  UserLoginViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 31/05/23.
//

import Foundation
import FirebaseAuth

extension SignInView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var userRepository = UserRepository()
        @Published private(set) var error: Error? = nil
        
        func signIn(email: String, password: String) {
            Task {
                do {
                    self.error = nil
                    try await userRepository.signIn(email: email, password: password)
                } catch {
                    self.error = error
                }
            }
        }
    }
}
