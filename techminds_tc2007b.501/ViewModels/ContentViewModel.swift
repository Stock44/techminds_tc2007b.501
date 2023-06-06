//
//  ContentViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 01/06/23.
//

import Foundation
import FirebaseAuth

extension ContentView{
    @MainActor class ViewModel : ObservableObject{
        @Published private(set) var userRepository = UserRepository()
    }
}
