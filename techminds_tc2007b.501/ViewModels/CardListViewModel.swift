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
    
    @Published var cardViewModels = Set<CardViewModel>()
    @Published var error: Error?
    
    func getCollectionCards(collection: CollectionViewModel) {
        do {
            try cardRepository.getCardsForCollection(collection: collection.collection)
            self.error = nil
        } catch {
            self.error = error
        }
    }
    
    func getAllCards() {
        do {
            try cardRepository.getCards()
            self.error = nil
        } catch {
            self.error = error
        }
    }
    
    init() {
        cardRepository
            .$cards
            .map { cards in
                Set(cards.map(CardViewModel.init))
            }
            .assign(to: \.cardViewModels, on: self)
            .store(in: &cancellables)
        
        
    }
}
