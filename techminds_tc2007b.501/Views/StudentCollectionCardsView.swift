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
        UserGrid<CardViewModel, CardView>(viewModels: [CardViewModel](viewModel.cards))
            .onAppear {
                viewModel.getCardsWithImages()
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
