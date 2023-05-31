//
//  AccountEditView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 31/05/23.
//

import SwiftUI

struct AccountEditView: View {
    @State var nombre = "Erick"
    @State var apellidos = "Hernandez"
    @State var correo = "A00@tec.mx"
    @State var contraseña = "dasfdaf"
    
    var body: some View {
        HStack{
            VStack (spacing: 30){
                LabelledTextBox(label: "Nombre", placeholder: "\(nombre)",content: $nombre)
                LabelledTextBox(label: "Apellidos", placeholder: "\(apellidos)",content: $apellidos)
                LabelledTextBox(label: "Correo", placeholder: "\(correo)",content: $correo)
                LabelledTextBox(label: "Contraseña", placeholder: "\(contraseña)",content: $contraseña)
            }
            .padding(.leading, 40)
            VStack{
                Spacer()
                HStack(alignment: .bottom){
                    FilledButton(labelText: "Guardar"){
                        
                    }
                     .padding(.bottom, 100)
                }
            }
            .padding(.horizontal, 150.0)
        }
    }
}

struct AccountEditView_Previews: PreviewProvider {
    static var previews: some View {
        AccountEditView()
    }
}
