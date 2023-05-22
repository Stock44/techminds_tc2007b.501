//
//  RegisterView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/05/23.
//

import SwiftUI

struct RegisterView: View {
    @State private var isRotating = 0.0
    
    @State private var nombre: String = ""
    @State private var apellido: String = ""
    @State private var email: String = ""
    @State private var contrasena: String = ""
    @State private var valcontrasena: String = ""
    
    @State private var nivel: Int = 1
    
    let nivelesDisponibles = Array(1...4)
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                ScrollView {
                VStack (alignment: .leading, spacing: 32) {
                    Text("Registro de Usuario")
                        .font(.custom("Comfortaa-Light", size: 72))
                        .padding()
                    
                    Group {
                        HStack {
                            LabelledTextBox(label: "Nombres(s) del alumno", placeholder: "Ingresa el nombre(s)", content: $nombre)
                            LabelledTextBox(label: "Apellido(s) del alumno", placeholder: "Ingresa el apellido(s)", content: $apellido)
                        }
                        LabelledTextBox(label: "Correo electrónico", placeholder: "Ingresa tu correo electrónico", content: $email)
                        LabelledTextBox(label: "Contraseña", placeholder: "Ingresa una contraseña", content: $contrasena)
                        LabelledTextBox(label: "Confirma tu contraseña", placeholder: "Ingresa la misma contraseña", content: $valcontrasena)
                        FilledButton(labelText: "Registrarse") {
                            // TODO registration through auth
                        }
                    }.frame(maxWidth: 512)
                    
                }
                .padding(EdgeInsets(top: 0, leading: 64, bottom: 0, trailing: 64))
                .frame(width: geo.size.width / 2)
            }
                ZStack{
                    Color("primary lighter")
                        .edgesIgnoringSafeArea(.all)
                    
                    // Logo o imagen de la app
                    Image("logo")
                        .resizable()
                        .frame(width: geo.size.width/4, height: geo.size.width/4)
                        .scaledToFill()
                        .rotationEffect(.degrees(isRotating))
                        .onAppear {
                            withAnimation(.linear(duration: 1)
                                .speed(0.1).repeatForever(autoreverses: false)) {
                                    isRotating = 360.0
                                }
                        }
                        .frame(width: geo.size.width/2)
                }
                
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
