//
//  CollectionInstructor.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 22/05/23.
//
import SwiftUI

struct CollectionInstructor: View {
    
    @State var isEditing = false
    @State var editingCollection: Collection? = nil
    @StateObject private var collectionsRepository = CollectionsRepository()
    
    init() {
        do { try collectionsRepository.getCollections()
        } catch {
            print("unable to get collections: \(error)")
        }
    }
    
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
            ForEach(collectionsRepository.collections, id: \.id) { collection in
                    Text(collection.name)
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
                    Task {
                        do {
                            try await collectionsRepository.createCollection(name: name, color: color, enabled: enabled)
                        } catch {
                            print("error while creating collection: \(error)")
                        }
                        isEditing = false
                    }
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
        CollectionInstructor()
    }
}

