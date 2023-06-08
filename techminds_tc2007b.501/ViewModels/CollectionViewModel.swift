//
//  CollectionViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 07/06/23.
//

import Foundation
import Combine

class CollectionViewModel: ObservableObject, Identifiable {
    private var collectionRepository = CollectionRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var collection: Collection
    @Published var error: Error?
    
    var id: String?
    
    init(collection: Collection = Collection()) {
        self.collection = collection
        
        $collection
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
    
    func create() {
        Task {
            do {
                try await collectionRepository.createCollection(collection: collection)
            } catch {
                self.error = error
            }
        }
    }
    
    func update() {
        Task {
            do {
                try await collectionRepository.updateCollection(collection: collection)
            } catch {
                self.error = error
            }
        }
    }
    
    func delete() {
        Task {
            do {
                try await collectionRepository.deleteCollection(collection: collection)
            } catch {
                self.error = error
            }
        }
    }
}
