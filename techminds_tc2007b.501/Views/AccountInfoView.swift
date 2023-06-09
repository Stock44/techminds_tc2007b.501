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
    @State var popup = false
    @State var buttontext = "Editar"
    @State var opacityEdit = 0.6
    @State var textedit = true
    @State var exito = false
    let ViewModel = UserViewModel()
    
    
    var body: some View {
        ZStack {
            VStack (spacing: 32){
                LabelledTextBox(label: "Nombre", placeholder: "\(nombre)",content: $nombre)
                        .disabled(textedit)
                        .opacity(opacityEdit)
                LabelledTextBox(label: "Apellidos", placeholder: "\(apellidos)",content: $apellidos)
                        .disabled(textedit)
                        .opacity(opacityEdit)
                LabelledTextBox(label: "Correo", placeholder: "\(correo)",content: $correo)
                        .disabled(textedit)
                        .opacity(opacityEdit)
                LabelledPasswordBox(label: "Contraseña", placeholder: "\(contraseña)",content: $contraseña)
                        .disabled(textedit)
                        .opacity(opacityEdit)
                    
                FilledButton(labelText: buttontext){
                    if buttontext == "Editar"{
                        popup = true
                    }
                    else{
                        //Guarda información
                        buttontext = "Editar"
                        opacityEdit = 0.6
                        textedit = true
                        exito = true
                    }
                }
                .popover(isPresented: $popup, content: {
                    VerifyPopUp(contraseña2: $contraseña, popup: $popup, buttontext: $buttontext, opacityEdit: $opacityEdit, textedit: $textedit)
                })
                .alert(isPresented: $exito){
                    Alert(
                        title: Text("Operación exitosa"),
                        message: Text( "Datos guardados correctamente")
                    )
                }
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
