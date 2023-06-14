//
//  CollectionCreationViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 11/06/23.
//

import Foundation

class CollectionCreationViewModel: ViewableCollectionViewModel, EditableCollectionMembers {
    private let collectionRepository = CollectionRepository()
    
    @Published @MainActor var collection = Collection()
    @Published @MainActor var cards: Set<CardViewModel>? = Set<CardViewModel>()
    @Published @MainActor private(set) var error: Error?
    
    @MainActor
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
    
    func save() {}
}
