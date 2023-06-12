//
//  UserCreationViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 11/06/23.
//

import Foundation

class UserCreationViewModel: ObservableObject{
    private var userRepository = UserRepository()
    private var userPropertiesRepository = UserPropertiesRepository()
    
    @Published @MainActor var email = ""
    @Published @MainActor var password = ""
    @Published @MainActor var userProperties = UserProperties()
    @Published @MainActor private(set) var error: Error?
    
    @MainActor
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
