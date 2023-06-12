//
//  CardListViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/06/23.
//

import Foundation
import Combine

class CardListViewModel: ObservableObject {
    private let cardRepository = CardRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published @MainActor private(set) var cardViewModels = Set<CardViewModel>()
    @Published @MainActor private(set) var error: Error?
    
    @MainActor
    init() {
        cardRepository
            .$cards
            .map { cards in
                Set(cards.map(CardViewModel.init))
            }
            .assign(to: \.cardViewModels, on: self)
            .store(in: &cancellables)
    }
    
    @MainActor
    func getAll() {
        do {
            try cardRepository.getCards()
            self.error = nil
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    func getAllWithImages() {
        
        do {
            $cardViewModels
                .sink {
                    for card in $0 {
                        card.loadImage()
                    }
                }
                .store(in: &cancellables)
            
            try cardRepository.getCards()
            self.error = nil
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    func getForCollection(collection: CollectionViewModel) {
        do {
            try cardRepository.getCardsForCollection(collection: collection.collection)
            self.error = nil
        } catch {
            self.error = error
        }
    }
}
