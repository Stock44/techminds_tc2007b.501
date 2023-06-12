//
//  CollectionMemberEditView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 09/06/23.
//

import SwiftUI
import FirebaseFirestore

protocol EditableCollectionMembers: ObservableObject {
    var cards: Set<CardViewModel>? { get set }
}


struct CollectionMemberEditView<ViewModel: EditableCollectionMembers>: View {
    @ObservedObject var viewModel: ViewModel
    @StateObject var cardListViewModel = CardListViewModel()
    @State var selection = Set<String?>()
    
    init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        
        
    }
    
    
    var body: some View {
        if viewModel.cards == nil {
            ProgressView()
        } else {
            List([CardViewModel](cardListViewModel.cardViewModels), selection: $selection) {
                Text($0.card.id ?? "")
            }
            .onChange(of: selection) { newSelection in
                viewModel.cards = Set(cardListViewModel.cardViewModels.filter {
                    return newSelection.contains($0.id)
                })
                print("selected \(viewModel.cards?.count ?? 0)")
            }
            .environment(\.editMode, Binding.constant(EditMode.active))
            .onAppear {
                cardListViewModel.getAll()
                if let cards = viewModel.cards {
                    selection = Set(cards.map {
                        print($0.id ?? "")
                        return $0.id
                    })
                }
            }
            
        }
        
    }
}

struct CollectionMemberEditView_Previews: PreviewProvider {
    @StateObject static var viewModel = CollectionEditingViewModel(collection: Collection())
    static var previews: some View {
        NavigationView {
            CollectionMemberEditView(viewModel: viewModel)
        }
        .navigationViewStyle(.stack)
    }
}
