//
//  CollectionInstructor.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 22/05/23.
//
import SwiftUI

struct InstructorCollectionsView: View {
    @State var editViewModel: CollectionViewModel?
    @StateObject private var viewModel = CollectionListViewModel()
    
    var body: some View {
        
        List {
            HStack(alignment: .center, spacing: 32) {
                Spacer(minLength: 32)
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
                HStack(alignment: .center, spacing: 32) {
                    Circle()
                        .fill(Color(cgColor: collection.collection.color.cgColor))
                        .frame(maxHeight: 32)
                    
                    Text(collection.collection.name)
                    
                    Text("test")
                    
                    Toggle("Enabled", isOn: Binding(get: {
                        collection.collection.enabled
                    }, set: { value in
                        collection.collection.enabled = value
                        collection.update()
                    }))
                    
                    Button {
                        editViewModel = collection
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .navigationTitle("Editar colecciones")
        .toolbar {
            ToolbarItemGroup (placement: .navigationBarTrailing) {
                Button {
                    editViewModel = CollectionViewModel()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }.sheet(isPresented: Binding(get: {editViewModel != nil}, set: {if !$0 {editViewModel = nil}})) {
            NavigationView {
                CollectionEditView(viewModel: editViewModel!)
            }
        }
    }
}
struct CollectionInstructor_Previews: PreviewProvider {
    static var previews: some View {
        InstructorCollectionsView()
    }
}

