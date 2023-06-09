//
//  CollectionsView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 18/05/23.
//

import SwiftUI

struct StudentCollectionsView: View {
    @StateObject var viewModel = CollectionListViewModel()
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        UserGrid<CollectionViewModel, CollectionDisplayView>(viewModels: $viewModel.collectionViewModels)
        .tabViewStyle(.page)
        .navigationTitle("Colecciones")
        .toolbar {
            ToolbarItemGroup (placement: .navigationBarTrailing){
                NavigationLink {
                    InstructorCollectionsView()
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        StudentCollectionsView()
    }
}
