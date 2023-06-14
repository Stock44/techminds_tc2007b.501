//
//  CardMemberEditView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 12/06/23.
//

import SwiftUI
import FirebaseFirestore

protocol EditableCardMembers: ObservableObject {
    var collections: Set<CollectionViewModel>? { get set }
    func save()
}

struct CardMemberEditView<ViewModel: EditableCardMembers>: View {
    @ObservedObject var viewModel: ViewModel
    @StateObject var collectionListViewModel = CollectionListViewModel()
    @State var selection = Set<String?>()
    @State private var guardado = false
    
    init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if viewModel.collections == nil {
            ProgressView()
        } else {
            List([CollectionViewModel](collectionListViewModel.collectionViewModels), selection: $selection) {
                Text($0.collection.name)
            }
            .onChange(of: collectionListViewModel.collectionViewModels) { newValue in
                if let collections = viewModel.collections {
                    selection = Set(collections.map {
                        print($0.id ?? "")
                        return $0.id
                    })
                }
            }
            .onChange(of: selection) { newSelection in
                viewModel.collections = Set(collectionListViewModel.collectionViewModels.filter {
                    return newSelection.contains($0.id)
                })
                print("selected \(viewModel.collections?.count ?? 0)")
            }
            .environment(\.editMode, Binding.constant(EditMode.active))
            .onAppear {
                collectionListViewModel.getAllOnce()
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

struct CardMemberEditView_Previews: PreviewProvider {
    @StateObject static var viewModel = CardEditingViewModel(card: Card())
    static var previews: some View {
        NavigationView {
            CardMemberEditView(viewModel: viewModel)
        }
        .navigationViewStyle(.stack)
    }
}
