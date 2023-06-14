//
//  CardEditingViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 11/06/23.
//

import Foundation
import Combine
import UIKit

class CardEditingViewModel: EditableCardMembers, ViewableCardViewModel {
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
    func save() {
        update()
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
                
                let collections = Set(collections?.map { $0.collection } ?? [])
                    
                try await cardRepository.updateCard(card: card)
                try await cardRepository.setCollectionsForCard(card: card, collections: collections)
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
    func loadImage() {
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
    func unloadImage() {
        cardImageRepository.unloadImage(imageID: card.imageID)
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
