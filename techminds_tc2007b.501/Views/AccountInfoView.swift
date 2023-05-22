//
//  AccountInfoView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI

struct AccountInfoView: View {
    @State private var nombre = "Erick"
    @State private var apellidos = "Hernandez"
    @State private var correo = "A00@tec.mx"
    @State private var contraseña = "dasfdaf"
    @State private var nivel = "2"
    
    var body: some View {
        HStack{
            VStack (spacing: 30){
                LabelledTextBox(label: "Nombre", placeholder: "\(nombre)",content: $nombre)
                    .disabled(true)
                LabelledTextBox(label: "Apellidos", placeholder: "\(apellidos)",content: $apellidos)
                    .disabled(true)
                LabelledTextBox(label: "Correo", placeholder: "\(correo)",content: $correo)
                    .disabled(true)
                LabelledTextBox(label: "Contraseña", placeholder: "\(contraseña)",content: $contraseña)
                    .disabled(true)
                LabelledTextBox(label: "Nivel", placeholder: "\(nivel)",content: $nivel)
                    .disabled(true)
            }
            .padding(.leading, 40)
            VStack{
                Spacer()
                HStack(alignment: .bottom){
                    FilledButton(labelText: "Editar") {
                    }
                    .padding(.bottom, 100)
                }
            }
            .padding(.horizontal, 150.0)
            
        }.navigationTitle("Detalles de cuenta")
    }
}

struct AccountInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AccountInfoView()
    }
}
