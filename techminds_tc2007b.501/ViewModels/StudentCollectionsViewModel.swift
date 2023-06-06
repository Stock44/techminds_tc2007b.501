//
//  StudentCollectionsViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 05/06/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


extension StudentCollectionsView{
    @MainActor class ViewModel : ObservableObject{
        @Published private(set) var user: FirebaseAuth.User?
        
        init() {
            Auth.auth().addStateDidChangeListener { auth, authUser in
                self.user = authUser
            }
        }
    }
}
