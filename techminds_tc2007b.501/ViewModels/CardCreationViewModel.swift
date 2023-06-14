//
//  CardCreationViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 11/06/23.
//

import Foundation
import UIKit

class CardCreationViewModel: ViewableCardViewModel {
    private let cardRepository = CardRepository()
    private let cardImageRepository = CardImageRepository()
    
    @Published @MainActor var card = Card()
    @Published @MainActor var cardImage: UIImage?
    @Published @MainActor private(set) var error: Error?
    
    @MainActor
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
    
    func loadImage() {
    }
    
    func unloadImage() {
    }
}
