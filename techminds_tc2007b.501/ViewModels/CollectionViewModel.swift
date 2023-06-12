//
//  CollectionViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 07/06/23.
//

import Foundation
import Combine

class CollectionViewModel: ViewableCollectionViewModel, Identifiable, Hashable {
    static func == (lhs: CollectionViewModel, rhs: CollectionViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    private var collectionRepository = CollectionRepository()
    private var cardRepository = CardRepository()
    private var cancellables = Set<AnyCancellable>()
    
    @Published @MainActor private(set) var collection: Collection
    @Published @MainActor private(set) var cards = Set<CardViewModel>()
    @Published @MainActor private(set) var error: Error?
    
    var id: String?
    
    @MainActor
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @MainActor
    init(collection: Collection) {
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
    
    @MainActor
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
    
    @MainActor
    func getCardsWithImages() {
        $cards
            .sink {
                for card in $0 {
                    card.loadImage()
                }
            }
            .store(in: &cancellables)
        
        do {
            print("getting cards")
            try cardRepository.getCardsForCollection(collection: collection)
            self.error = nil
        } catch {
            print("error \(error)")
            self.error = error
        }
    }
    
}
