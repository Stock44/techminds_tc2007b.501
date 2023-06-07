//
//  CollectionDetailView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 07/06/23.
//

import SwiftUI

struct CollectionEditView: View {
    @State var name: String = ""
    @State var color: Color = .blue
    @State var enabled: Bool = false
    
    
    var submitAction: (String, Color, Bool) -> Void
    
    var deleteAction: (() -> Void)? = nil
    
    @State private var showDelete: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32){
            CollectionDisplayView(name: name, color: color)
            Text("Editando colección")
                .typography(.title)
            LabelledTextBox(label: "Nombre", placeholder: "Ingresa el nombre de la Coleccion", content: $name)
            
            ColorPicker(selection: $color, supportsOpacity: false, label: {
                Text("Color")
                    .typography(.callout)
                .frame(height: 56)
                .cornerRadius(16)
            })
            
            Toggle("Habilitada", isOn: $enabled)
            
            HStack {
                if deleteAction != nil {
                    Button (role: .destructive) {
                        showDelete = true
                    } label: {
                        Image(systemName: "trash")
                    }
                    .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
                    .confirmationDialog("¿Seguro que quieres borrar esta colección?", isPresented: $showDelete) {
                        Button("Borrar colección", role: .destructive) {
                            deleteAction!()
                        }
                    }
                }
                
                FilledButton(labelText: "Confirmar") {
                    submitAction(name, color, enabled)
                }
            }
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        
    }
}

struct CollectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionEditView {_,_,_ in } deleteAction: {}
    }
}
