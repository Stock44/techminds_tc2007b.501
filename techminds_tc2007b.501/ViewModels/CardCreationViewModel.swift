//
//  CardCreationViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 11/06/23.
//

import Foundation
import UIKit

@MainActor
class CardCreationViewModel: ViewableCardViewModel {
    private let cardRepository = CardRepository()
    private let cardImageRepository = CardImageRepository()
    
    @Published var card = Card()
    @Published var cardImage: UIImage?
    @Published private(set) var error: Error?
    
    func create() {
        guard let cardImage = cardImage else {
            self.error = RepositoryError.invalidModel
            return
        }
        
        Task {
            do {
                card.imageID = try await cardImageRepository.addImage(image: cardImage)
                try await cardRepository.createCard(card: card)
                
                self.error = nil
            } catch {
                self.error = error
            }
        }
    }
}
