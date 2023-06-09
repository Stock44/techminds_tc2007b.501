//
//  CollectionCreationView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 07/06/23.
//

import SwiftUI

struct CollectionEditView: ViewModelView {
    typealias ViewModel = CollectionViewModel
    
    @State private var showDelete: Bool = false
    @ObservedObject private var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32){
            CollectionDisplayView(viewModel: viewModel)
            
            if viewModel.id == nil {
                Text("Nueva colección")
                    .typography(.title)
            } else {
                Text("Editar colección")
                    .typography(.title)
            }
            
            LabelledTextBox(label: "Nombre", placeholder: "Ingresa el nombre de la Coleccion", content: $viewModel.collection.name)
            
            ColorPicker(selection: $viewModel.collection.color.cgColor, supportsOpacity: false, label: {
                Text("Color")
                    .typography(.callout)
                    .frame(height: 56)
                    .cornerRadius(16)
            })
            
            
            
            Toggle("Habilitada", isOn: $viewModel.collection.enabled)
            
            NavigationLink {
                CollectionMemberEditView(viewModel: viewModel)
            } label: {
                Label("Tarjetas de la colección", systemImage: "rectangle.3.group")
            }
            
            
            HStack {
                if (viewModel.id != nil) {
                    Button (role: .destructive) {
                        showDelete = true
                    } label: {
                        Image(systemName: "trash")
                    }
                    .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
                    .confirmationDialog("¿Seguro que quieres borrar esta colección?", isPresented: $showDelete) {
                        Button("Borrar colección", role: .destructive) {
                            viewModel.delete()
                            dismiss()
                        }
                    }
                }
                
                FilledButton(labelText: "Confirmar") {
                    if viewModel.id == nil {
                        viewModel.create()
                    } else {
                        viewModel.update()
                    }
                    dismiss()
                }
            }
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        
    }
}

struct CollectionCreationView_Previews: PreviewProvider {
    @StateObject static var viewModel = CollectionViewModel()
    static var previews: some View {
        CollectionEditView(viewModel: viewModel)
    }
}
