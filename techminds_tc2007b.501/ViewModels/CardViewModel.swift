//
//  CardViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/06/23.
//

import Foundation
import Combine

class CardViewModel: ObservableObject, Identifiable {
    private var cardRepository = CardRepository()
    private var cardImageRepository = CardImageRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var card: Card
    @Published var error: Error?
    
    var id: String?
    
    init(card: Card = Card()) {
        self.card = card
        
        $card
            .compactMap {
                $0.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        
        cardImageRepository
            .$images
            .map { images in
                if let imageID = card.imageID {
                    return images[imageID]
                } else {
                    return nil
                }
            }
            .assign(to: \.card.image,on: self)
            .store(in: &cancellables)
        
        
        
        if let imageID = card.imageID {
            Task {
                do {
                    try await cardImageRepository.getImage(imageID: imageID)
                    self.error = nil
                } catch {
                    self.error = error
                }
            }
        }
        
    }
    
    func create() {
        Task {
            do {
                try await cardRepository.createCard(card: card)
                self.error = nil
            } catch {
                self.error = error
            }
        }
    }
    
    func update() {
        Task {
            do {
                try await cardRepository.updateCard(card: card)
                self.error = nil
            } catch {
                self.error = error
            }
        }
    }
    
    func delete() {
        Task {
            do {
                try await cardRepository.deleteCard(card: card)
                self.error = nil
            } catch {
                self.error = error
            }
        }
    }
}
