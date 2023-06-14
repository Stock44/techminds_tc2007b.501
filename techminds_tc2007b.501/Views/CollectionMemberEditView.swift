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
    func save()
}

struct CollectionMemberEditView<ViewModel: EditableCollectionMembers>: View {
    @ObservedObject var viewModel: ViewModel
    @StateObject var cardListViewModel = CardListViewModel()
    @State var selection = Set<String?>()
    @State private var guardado = false
    
    init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if viewModel.cards == nil {
            ProgressView()
        } else {
                List([CardViewModel](cardListViewModel.cardViewModels), selection: $selection) {
                    Text($0.card.name)
                }
                .onChange(of: cardListViewModel.cardViewModels) { newValue in
                    if let cards = viewModel.cards {
                        selection = Set(cards.map {
                            print($0.id ?? "")
                            return $0.id
                        })
                    }
                }

            
            .onChange(of: selection) { newSelection in
                viewModel.cards = Set(cardListViewModel.cardViewModels.filter {
                    return newSelection.contains($0.id)
                })
                print("selected \(viewModel.cards?.count ?? 0)")
            }
            .environment(\.editMode, Binding.constant(EditMode.active))
            .onAppear {
                cardListViewModel.getAllOnce()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.save()
                        guardado = true
                    } label: {
                        Text("Guardar")
                    }.popover(isPresented: $guardado){
                        ZStack {
                            Color("secondary lighter")
                                .scaleEffect(1.5)
                            Text("Guardado con éxito")
                                .typography(.callout)
                                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color("secondary"))
                        }
                    }
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
