//
//  CollectionsView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 18/05/23.
//

import SwiftUI

struct StudentCollectionsView: View {
    @StateObject var userRepository = UserRepository()
    @StateObject var collectionsRepository = CollectionsRepository()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: (0..<(userRepository.user?.rows ?? 4)).map { _ in
                return GridItem(.flexible())
            }) {
                ForEach(collectionsRepository.collections, id: \.id) { value in
                    CollectionButton(action: "", collectionColor: "primary lighter", collectionTitle: value.name, titleColor: "primary darker")
                }
            }
        }
        .navigationTitle("Colecciones")
        .toolbar {
            ToolbarItemGroup (placement: .navigationBarTrailing){
                Button {
                    
                } label: {
                    Image("pencil")
                }
            }
        }
        .padding(EdgeInsets(top: 32, leading: 48, bottom: 32, trailing: 48))
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        StudentCollectionsView()
    }
}
