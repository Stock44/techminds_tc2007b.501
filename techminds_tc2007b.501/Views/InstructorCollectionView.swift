//
//  CollectionInstructor.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 22/05/23.
//
import SwiftUI

struct InstructorCollectionView: View {
    
    @State var isEditing = false
    @State var editingCollection: Collection? = nil
    @StateObject private var viewModel = CollectionListViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            //Right Side
            HStack {
                Text("Nombre")
                    .font(.custom("Raleway-bold", size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("# de tarjetas")
                    .font(.custom("Raleway-bold", size: 18))
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Habilitar")
                    .font(.custom("Raleway-bold", size: 18))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text("")
                    .font(.custom("Raleway-bold", size: 18))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            ForEach(viewModel.collectionViewModels, id: \.id) { collection in
                Text(collection.collection.name)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 64, bottom: 0, trailing: 64))
        .frame(maxWidth: .infinity)
        .navigationTitle("Editar colecciones")
        .toolbar {
            ToolbarItemGroup (placement: .navigationBarTrailing) {
                Button {
                    isEditing = true
                    editingCollection = nil
                } label: {
                    Image(systemName: "plus")
                }
            }
        }.sheet(isPresented: $isEditing) {
            if let collection = editingCollection {
                CollectionEditView {name, color, enabled in}  deleteAction: {}
            } else {
                CollectionEditView { name, color, enabled in
                    viewModel.create(name: name, color: color, enabled: enabled)
                    isEditing = false
                }
            }
        }
        
        //Left Side
        //Color("white")
         //   .edgesIgnoringSafeArea(.all)
    }
}
struct CollectionInstructor_Previews: PreviewProvider {
    static var previews: some View {
        InstructorCollectionView()
    }
}

