//
//  CollectionViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 07/06/23.
//

import Foundation
import Combine

class CollectionViewModel: ObservableObject, Identifiable, Hashable {
    static func == (lhs: CollectionViewModel, rhs: CollectionViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    private var collectionRepository = CollectionRepository()
    private var cardRepository = CardRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var collection: Collection
    @Published private(set)var cards = Set<CardViewModel>()
    @Published var error: Error?
    
    var id: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    
    init(collection: Collection = Collection()) {
        self.collection = collection
        
        $collection
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        cardRepository
            .$cards
            .map { cards in
                Set(cards.map(CardViewModel.init))
            }
            .assign(to: \.cards, on: self)
            .store(in: &cancellables)
    }
    
    func addCards (cards: Set<CardViewModel>) {
        Task {
            do {
                let cards = Set(cards.map {$0.card})
                try await collectionRepository.addCardsToCollection(collection: collection, cards: cards)
                self.error = nil
            } catch {
                print("failed adding card: \(error)")
                self.error = error
            }
        }
    }
    
    func getCards() {
        do {
            print("getting cards")
            try cardRepository.getCardsForCollection(collection: collection)
            self.error = nil
        } catch {
            print("error \(error)")
            self.error = error
        }
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
