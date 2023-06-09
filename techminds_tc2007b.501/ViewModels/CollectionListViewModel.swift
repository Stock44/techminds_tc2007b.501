//
//  CollectionsRepository.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 06/06/23.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import Combine

class CollectionListViewModel : ObservableObject {
    private let collectionRepository = CollectionRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var collectionViewModels: [CollectionViewModel] = []
    @Published var error: Error?
    
    init() {
        collectionRepository
            .$collections
            .map { collections in
                collections.map(CollectionViewModel.init)
            }
            .assign(to: \.collectionViewModels, on: self)
            .store(in: &cancellables)
        
        do {
            try collectionRepository.getCollections()
        } catch {
            self.error = error
        }
    }
}
