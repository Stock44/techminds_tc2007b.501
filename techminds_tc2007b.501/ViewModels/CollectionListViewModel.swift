//
//  CollectionsRepository.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 06/06/23.
//

import Foundation
import Combine

class CollectionListViewModel : ObservableObject {
    private let collectionRepository = CollectionRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published @MainActor var collectionViewModels: Set<CollectionViewModel> = []
    @Published @MainActor var error: Error?
    
    @MainActor
    init() {
        collectionRepository
            .$collections
            .map { collections in
                Set(collections.map(CollectionViewModel.init))
            }
            .assign(to: \.collectionViewModels, on: self)
            .store(in: &cancellables)
    }
    
    @MainActor
    func getAllOnce() {
        Task {
            @MainActor () -> Void in
            
            do {
                try await collectionRepository.getCollectionsOnce()
                self.error = nil
            } catch {
                self.error = error
            }
        }
    }
    
    @MainActor
    func getAll() {
        do {
            try collectionRepository.getCollections()
            self.error = nil
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    func getForCard(card: CardViewModel) {
        do {
            try collectionRepository.getCollectionsForCard(card: card.card)
            self.error = nil
        } catch {
            self.error = error
        }
    }
}
