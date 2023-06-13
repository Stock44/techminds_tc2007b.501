//
//  CollectionsView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 18/05/23.
//

import SwiftUI

struct StudentCollectionsView: View {
    @StateObject var viewModel = CollectionListViewModel()
    
    var body: some View {
        UserDataGrid(viewModel.collectionViewModels.filter {
            $0.collection.enabled
        }, emptyLabel: "No has creado ninguna colección.") { collection in
            NavigationLink {
                StudentCollectionCardsView(viewModel: collection)
            } label: {
                CollectionDisplayView(viewModel: collection)
            }
        }
        .navigationTitle("Colecciones")
        .toolbar {
            ToolbarItemGroup (placement: .navigationBarTrailing){
                NavigationLink {
                    Filter{
                        InstructorCollectionsView(viewModel: viewModel)
                    }
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }.onAppear {
            viewModel.getAll()
        }
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        StudentCollectionsView()
    }
}
