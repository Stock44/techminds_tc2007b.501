//
//  CardViewModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/06/23.
//

import Foundation
import Combine
import UIKit

class CardViewModel: ViewableCardViewModel, Identifiable, Hashable {
    private var cardRepository = CardRepository()
    private var collectionRepository = CollectionRepository()
    private var cardImageRepository = CardImageRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published @MainActor private(set) var card: Card
    @Published @MainActor private(set) var collections = Set<CollectionViewModel>()
    @Published @MainActor private(set) var cardImage: UIImage?
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
        
        collectionRepository
            .$collections
            .compactMap { Set($0.map(CollectionViewModel.init)) }
            .assign(to: \.collections, on: self)
            .store(in: &cancellables)
        
        
        cardImageRepository
            .$images
            .map { $0[card.imageID] }
            .assign(to: \.cardImage,on: self)
            .store(in: &cancellables)
        
    }
    
    @MainActor
    func loadImage() {
        Task {
            do {
                _ = try await cardImageRepository.getImage(imageID: card.imageID)
                self.error = nil
            } catch {
                print("image \(error)")
                self.error = error
            }
        }
    }
    
    @MainActor
    static func == (lhs: CardViewModel, rhs: CardViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    @MainActor
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
