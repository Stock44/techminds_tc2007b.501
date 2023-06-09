//
//  CardViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/06/23.
//

import Foundation
import Combine
import UIKit

class CardViewModel: ObservableObject, Identifiable, Hashable {
    static func == (lhs: CardViewModel, rhs: CardViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    private var cardRepository = CardRepository()
    private var cardImageRepository = CardImageRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var card: Card
    @Published var collections = Set<CollectionViewModel>()
    @Published var cardImage: UIImage?
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
        
        cardRepository
            .$collections
            .compactMap { Set($0.map(CollectionViewModel.init)) }
            .assign(to: \.collections, on: self)
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
            .assign(to: \.cardImage,on: self)
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
    
    func loadImage() {
        guard let imageID = card.imageID else {
            return
        }
        
        Task {
            do {
                try await cardImageRepository.getImage(imageID: imageID)
                self.error = nil
            } catch {
                self.error = error
            }
        }
    }
    
    func create() {
        guard let cardImage = cardImage else {
            self.error = RepositoryError.invalidModel
            return
        }
        
        guard card.imageID == nil else {
            self.error = RepositoryError.invalidModel
            return
        }
        
        Task {
            do {
                card.imageID = try await cardImageRepository.addImage(image: cardImage)
                try await cardRepository.createCard(card: &card)
                self.error = nil
            } catch {
                self.error = error
            }
        }
    }
    
    func update() {
        guard let cardImage = cardImage else {
            self.error = RepositoryError.invalidModel
            return
        }
        
        guard let cardImageId = card.imageID else {
            self.error = RepositoryError.invalidModel
            return
        }
        
        Task {
            do {
                try await cardImageRepository.deleteImage(imageID: cardImageId)
                
                card.imageID = try await cardImageRepository.addImage(image: cardImage)
                
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
