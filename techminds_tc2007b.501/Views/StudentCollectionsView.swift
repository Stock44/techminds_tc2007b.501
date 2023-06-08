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
        let columns = userViewModel.user?.columns ?? 3
        let rows = userViewModel.user?.rows ?? 3
        TabView {
            ForEach(Array(stride(from: 0, to: viewModel.collectionViewModels.count, by: columns * rows)), id: \.self) { offset in
                Grid (horizontalSpacing: 16, verticalSpacing: 16){
                    ForEach(0..<rows, id: \.self) { row in
                        let start = min(offset + row * columns, viewModel.collectionViewModels.count)
                        let end = min(offset + (row + 1) * columns, viewModel.collectionViewModels.count)
                        let missing = columns - (end - start)
                        GridRow {
                            ForEach(viewModel.collectionViewModels[start..<end]) { collection in
                                CollectionDisplayView(viewModel: collection)
                            }
                            ForEach(0..<missing, id: \.self) { _ in
                                Color.clear
                            }
                        }
                        
                    }
                }
                .padding(EdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32))
            }
        }
        .tabViewStyle(.page)
        .navigationTitle("Colecciones")
        .toolbar {
            ToolbarItemGroup (placement: .navigationBarTrailing){
                NavigationLink {
                    InstructorCollectionView()
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
