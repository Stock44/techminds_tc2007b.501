//
//  CollectionDetailView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 07/06/23.
//

import SwiftUI

struct CollectionEditView: View {
    @StateObject var viewModel: CollectionViewModel
    
    @State private var showDelete: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32){
            CollectionDisplayView(viewModel: viewModel)
            Text("Editando colección")
                .typography(.title)
            LabelledTextBox(label: "Nombre", placeholder: "Ingresa el nombre de la Coleccion", content: $viewModel.collection.name)
            
            ColorPicker(selection: Binding {
                viewModel.collection.color.cgColor
            } set: { value, _ in
                viewModel.collection.color = CodableColor(cgColor: value)
            }, supportsOpacity: false, label: {
                Text("Color")
                    .typography(.callout)
                    .frame(height: 56)
                    .cornerRadius(16)
            })
            
            Toggle("Habilitada", isOn: $viewModel.collection.enabled)
            
            HStack {
                Button (role: .destructive) {
                    showDelete = true
                } label: {
                    Image(systemName: "trash")
                }
                .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
                .confirmationDialog("¿Seguro que quieres borrar esta colección?", isPresented: $showDelete) {
                    Button("Borrar colección", role: .destructive) {
                    }
                }
                
                FilledButton(labelText: "Guardar cambios") {
                    viewModel.update()
                    dismiss()
                }
            }
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        
    }
}

struct CollectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionEditView(viewModel: CollectionViewModel())
    }
}
