//
//  CollectionMemberEditView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 09/06/23.
//

import SwiftUI
import Combine
import FirebaseFirestore

struct CollectionMemberEditView: View {
    typealias ViewModel = CollectionViewModel
    
    @ObservedObject var viewModel: ViewModel
    @StateObject var cardViewModel = CardListViewModel()
    @State var selection = Set<String?>()
    private var cancellables: Set<AnyCancellable> = []
    
    init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        
    }
    
    var body: some View {
        List([CardViewModel](cardViewModel.cardViewModels), selection: $selection) {
            Text($0.card.name)
        }
        .environment(\.editMode, Binding.constant(EditMode.active))
        .onDisappear {
            let filteredCards = Set(cardViewModel.cardViewModels.filter {
                selection.contains($0.id)
            })
            
            if filteredCards == viewModel.cards {
                return
            }
            
            let newCards = filteredCards.subtracting(viewModel.cards)
            if newCards.count > 0 {
                viewModel.addCards(cards: newCards)
            }
            
            let removedCards = viewModel.cards.subtracting(filteredCards)
            if removedCards.count > 0 {
                viewModel.removeCards(cards: removedCards)
            }
        }.onAppear {
            cardViewModel.getAllCards()
            
            selection = Set(self.viewModel.cards.map {
                $0.id
            })
            
            if viewModel.id != nil {
                viewModel.getCards()
            }
        }.onChange(of: self.viewModel.cards) {
            selection = Set($0.map {
                $0.id
            })
        }
    }
}

struct CollectionMemberEditView_Previews: PreviewProvider {
    @StateObject static var viewModel = CollectionViewModel()
    static var previews: some View {
        NavigationView {
            CollectionMemberEditView(viewModel: viewModel)
        }
        .navigationViewStyle(.stack)
    }
}
