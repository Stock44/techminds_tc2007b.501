//
//  CollectionInstructor.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 22/05/23.
//
import SwiftUI

struct InstructorCollectionsView: View {
    @State private var isCreating = false
    @State private var editViewModel: CollectionEditingViewModel?
    @ObservedObject var viewModel: CollectionListViewModel
    
    var body: some View {
        
        List {
            HStack(alignment: .center, spacing: 32) {
                Spacer(minLength: 32)
                Text("Nombre")
                    .font(.custom("Raleway-bold", size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Habilitar")
                    .font(.custom("Raleway-bold", size: 18))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text("")
                    .font(.custom("Raleway-bold", size: 18))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            
            ForEach(viewModel.collectionViewModels.sorted(by: { v1, v2 in
                v1.collection.name < v2.collection.name
            }), id: \.id) { collection in
                let editCollection = CollectionEditingViewModel(collection: collection.collection)
                HStack(alignment: .center, spacing: 32) {
                    Circle()
                        .fill(Color(cgColor: collection.collection.color.cgColor))
                        .frame(maxHeight: 32)
                    
                    Spacer()
                    
                    Text(collection.collection.name)
                    
                    Spacer()
                    
                    Toggle(isOn: Binding(get: {
                        collection.collection.enabled
                    }, set: { value in
                        editCollection.collection.enabled = value
                        editCollection.update()
                    })) {
                        
                    }
                    
                    Spacer()
                    
                    Button {
                        editViewModel = editCollection
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
                    isCreating = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }.sheet(isPresented: Binding(get: {editViewModel != nil}, set: {if !$0 {editViewModel = nil}})) {
            NavigationView {
                CollectionEditView(viewModel: editViewModel!)
            }
        }.sheet(isPresented: $isCreating) {
            NavigationView {
                CollectionCreationView()
            }
        }
    }
}
struct CollectionInstructor_Previews: PreviewProvider {
    @StateObject static var viewModel = CollectionListViewModel()
    static var previews: some View {
        InstructorCollectionsView(viewModel: viewModel)
    }
}

