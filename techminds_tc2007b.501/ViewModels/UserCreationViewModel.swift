//
//  UserCreationViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 11/06/23.
//

import Foundation

@MainActor
class UserCreationViewModel: ObservableObject{
    private var userRepository = UserRepository()
    private var userPropertiesRepository = UserPropertiesRepository()
    
    @Published var email = ""
    @Published var password = ""
    @Published var userProperties = UserProperties()
    @Published private(set) var error: Error?
    
    func create() {
        guard userProperties.id == nil else {
            self.error = RepositoryError.alreadyExists
            return
        }
        
        Task {
            do {
                try await userRepository.register(email: email, password: password)
                try await userPropertiesRepository.setUserProperties(userProperties: userProperties)
                self.error = nil
            } catch  {
                self.error = error
            }
        }
    }
}
