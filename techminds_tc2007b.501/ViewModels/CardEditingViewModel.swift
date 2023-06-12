//
//  CardEditingViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 11/06/23.
//

import Foundation
import Combine
import UIKit

class CardEditingViewModel: ObservableObject, ViewableCardViewModel {
    private var cardRepository = CardRepository()
    private var collectionRepository = CollectionRepository()
    private var cardImageRepository = CardImageRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published @MainActor var card: Card
    @Published @MainActor var collections: Set<CollectionViewModel>?
    @Published @MainActor var cardImage: UIImage?
    @Published @MainActor private(set) var error: Error?
    
    var id: String?
    
    @MainActor
    init(card: Card) {
        self.card = card
        
        $card
            .compactMap {
                $0.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
    }
    
    @MainActor
    func update() {
        Task {
            do {
                if let image = cardImage {
                    let oldImageID = card.imageID
                    card.imageID = try await cardImageRepository.addImage(image: image)
                    try await cardImageRepository.deleteImage(imageID: oldImageID)
                }
                    
                try await cardRepository.updateCard(card: card)
            } catch {
                self.error = error
            }
        }
    }
    
    @MainActor
    func loadCurrentCollections() {
        Task {
            @MainActor () -> Void in
            do {
                self.collections = Set(try await collectionRepository.getCollectionsForCardOnce(card: card).map(CollectionViewModel.init))
                self.error = nil
            } catch {
                self.error = error
            }
        }
    }
    
    @MainActor
    func loadCurrentImage() {
        Task {
            do {
                self.cardImage = try await cardImageRepository.getImage(imageID: card.imageID)
                self.error = nil
            } catch {
                self.error = error
            }
        }
    }
    
    @MainActor
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
