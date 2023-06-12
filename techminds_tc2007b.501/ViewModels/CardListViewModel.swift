//
//  CardListViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/06/23.
//

import Foundation
import Combine

@MainActor
class CardListViewModel: ObservableObject {
    private let cardRepository = CardRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published private(set) var cardViewModels = Set<CardViewModel>()
    @Published private(set) var error: Error?
    
    init() {
        cardRepository
            .$cards
            .map { cards in
                Set(cards.map(CardViewModel.init))
            }
            .assign(to: \.cardViewModels, on: self)
            .store(in: &cancellables)
    }
    
    func getAll() {
        do {
            try cardRepository.getCards()
            self.error = nil
        } catch {
            self.error = error
        }
    }
    
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
    
    func getForCollection(collection: CollectionViewModel) {
        do {
            try cardRepository.getCardsForCollection(collection: collection.collection)
            self.error = nil
        } catch {
            self.error = error
        }
    }
}
