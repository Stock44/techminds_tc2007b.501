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
            if popup {
                VerifyPopUp()
            }
            HStack{
                VStack (spacing: 30){
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
                }
                .padding(.leading, 40)
                VStack{
                    Spacer()
                    HStack(alignment: .bottom){
                        FilledButton(labelText: buttontext){
                            if buttontext == "Editar"{
                                popup = true
                            }
                        }
                        .padding(.bottom, 100)
                    }
                }
                .padding(.horizontal, 150.0)
                
            }.navigationTitle("Detalles de cuenta")
        }
    }
}

struct AccountInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AccountInfoView()
    }
}
