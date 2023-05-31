//
//  UserLoginViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 31/05/23.
//

import Foundation
import FirebaseAuth

extension LogInView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var authError: AuthErrorCode?
        
        func login(email: String, password: String) {
            Task{
                do {
                    try await Auth.auth().signIn(withEmail: email, password: password)
                } catch let err as AuthErrorCode {
                    print("error")
                    authError = err
                } catch {
                    print("unknown error")
                }
            }
        }
    }
    
}
