//
//  CollectionCreationViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 11/06/23.
//

import Foundation

@MainActor
class CollectionCreationViewModel: ViewableCollectionViewModel, EditableCollectionMembers {
    private let collectionRepository = CollectionRepository()
    
    @Published var collection = Collection()
    @Published var cards: Set<CardViewModel>? = Set<CardViewModel>()
    @Published private(set) var error: Error?
    
    func create() {
        Task {
            do {
                try await collectionRepository.createCollection(collection: collection)
                
                let cards = Set(cards?.map { $0.card } ?? [])
                
                try await collectionRepository.setCardsForCollection(collection: collection, cards: cards)
                
                self.error = nil
            } catch {
                self.error = error
            }
        }
    }
}
