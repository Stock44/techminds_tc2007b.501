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
    
    @Published var cardViewModels: [CardViewModel] = []
    @Published var error: Error?
    
    init() {
        cardRepository
            .$cards
            .map { cards in
                cards.map(CardViewModel.init)
            }
            .assign(to: \.cardViewModels, on: self)
            .store(in: &cancellables)
        
        do {
            try cardRepository.getCards()
        } catch {
            self.error = error
        }
    }
}
