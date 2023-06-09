//
//  CollectionCreationView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 07/06/23.
//

import SwiftUI

struct CollectionCreationView: View {
    @State private var showDelete: Bool = false
    @State private var viewModel = CollectionViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32){
            CollectionDisplayView(viewModel: viewModel)
            Text("Nueva colección")
                .typography(.title)
            LabelledTextBox(label: "Nombre", placeholder: "Ingresa el nombre de la Coleccion", content: $viewModel.collection.name)
            
            ColorPicker(selection: $viewModel.collection.color.cgColor, supportsOpacity: false, label: {
                Text("Color")
                    .typography(.callout)
                    .frame(height: 56)
                    .cornerRadius(16)
            })
            
            Toggle("Habilitada", isOn: $viewModel.collection.enabled)
            
            HStack {
                FilledButton(labelText: "Confirmar") {
                    viewModel.create()
                    dismiss()
                }
            }
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        
    }
}

struct CollectionCreationView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionCreationView()
    }
}
