//
//  AccountInfoView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI

struct AccountInfoView: View {
    @State var nombre = "Erick"
    @State var apellidos = "Erick"
    @State var correo = "A00@tec.mx"
    @State var contraseña = "hola"
    @State private var popup = false
    @State private var buttontext = "Editar"
    
    
    var body: some View {
        ZStack {
            VStack (spacing: 32){
                LabelledTextBox(label: "Nombre", placeholder: "\(nombre)",content: $nombre)
                        .disabled(true)
                        .opacity(0.6)
                LabelledTextBox(label: "Apellidos", placeholder: "\(apellidos)",content: $apellidos)
                        .disabled(true)
                        .opacity(0.6)
                LabelledTextBox(label: "Correo", placeholder: "\(correo)",content: $correo)
                        .disabled(true)
                        .opacity(0.6)
                LabelledTextBox(label: "Contraseña", placeholder: "\(contraseña)",content: $contraseña)
                        .disabled(true)
                        .opacity(0.6)
                    
                FilledButton(labelText: buttontext){
                    if buttontext == "Editar"{
                        popup = true
                    }
                }
                .popover(isPresented: $popup, content: {
                    VerifyPopUp()
                })
                .padding(.bottom, 100)
            }
            .padding(.leading, 40)
            .navigationTitle("Información de la cuenta")
        }
        .frame(maxWidth: .infinity)
    }
}

struct AccountInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AccountInfoView()
    }
}
