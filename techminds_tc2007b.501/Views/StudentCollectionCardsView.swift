//
//  StudentCollectionCardsView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 09/06/23.
//

import SwiftUI

struct StudentCollectionCardsView: View {
    @ObservedObject var viewModel: CollectionViewModel
    @State private var isEditing = false
    
    var body: some View {
        UserDataGrid(viewModel.cards.sorted(by: { v1, v2 in
            v1.card.name < v2.card.name
        }), emptyLabel: "No hay tarjetas en esta colección.") {
            CardView(viewModel: $0, customColor: Color(cgColor: viewModel.collection.color.cgColor))
        }
        .onAppear {
            viewModel.getCards()
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    isEditing = true
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
        .navigationTitle(viewModel.collection.name)
        .sheet(isPresented: $isEditing) {
            NavigationView {
                Filter {
                    CollectionEditView(viewModel: CollectionEditingViewModel(collection: viewModel.collection))
                }
            }
        }
    }
}

struct StudentCollectionCardsView_Previews: PreviewProvider {
    @StateObject static var viewModel = CollectionViewModel(collection: Collection())
    
    static var previews: some View {
        StudentCollectionCardsView(viewModel: viewModel)
    }
}
