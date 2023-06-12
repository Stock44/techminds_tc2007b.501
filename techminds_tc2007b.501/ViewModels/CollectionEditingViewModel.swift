//
//  CollectionEditingViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 12/06/23.
//

import Foundation
import Combine

@MainActor
class CollectionEditingViewModel: ViewableCollectionViewModel, EditableCollectionMembers {
    private var collectionRepository = CollectionRepository()
    private var cardRepository = CardRepository()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var collection: Collection
    @Published var cards: Set<CardViewModel>?
    @Published private(set) var error: Error?
    
    var id: String?
    
    init(collection: Collection) {
        self.collection = collection
        
        $collection
            .compactMap {
                $0.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
    
    func update() {
        Task {
            do {
                let cards = Set(cards?.map { $0.card } ?? [])
                print("\(cards.count)")
                try await collectionRepository.updateCollection(collection: collection)
                try await collectionRepository.setCardsForCollection(collection: collection, cards: cards)
                self.error = nil
            } catch {
                self.error = error
            }
        }
    }
    
    func loadCurrentCards() {
        Task {
            do {
                self.cards = Set(try await cardRepository.getCardsForCollectionOnce(collection: collection).map(CardViewModel.init))
                self.error = nil
            } catch {
                self.error = error
            }
        }
    }
    
    func delete() {
        Task {
            do {
                try await collectionRepository.deleteCollection(collection: collection)
                self.error = nil
            } catch {
                self.error = error
            }
        }
    }
}

