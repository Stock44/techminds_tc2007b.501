//
//  RegisterView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/05/23.
//

import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @State private var isRotating = 0.0
    
    @StateObject private var viewModel = UserCreationViewModel()
    @State private var passwordValidation: String = ""
    
    @State var errorMsg: String? = nil
    
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
                                LabelledTextBox(label: "Nombres(s) del alumno", placeholder: "Ingresa el nombre(s)", content: $viewModel.userProperties.name)
                                LabelledTextBox(label: "Apellido(s) del alumno", placeholder: "Ingresa el apellido(s)", content: $viewModel.userProperties.surname)
                            }
                            LabelledTextBox(label: "Correo electrónico", placeholder: "Ingresa tu correo electrónico", content: $viewModel.email)
                            LabelledPasswordBox(label: "Contraseña", placeholder: "Ingresa una contraseña", content: $viewModel.password)
                            LabelledPasswordBox(label: "Confirma tu contraseña", placeholder: "Ingresa la misma contraseña", content: $passwordValidation)
                            FilledButton(labelText: "Registrarse") {
                                viewModel.create()
                            }
                        }.frame(maxWidth: 512)
                        
                    }
                        .offset(y: geo.size.height/30)
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
                        /*.rotationEffect(.degrees(isRotating))
                        .onAppear {
                            withAnimation(.linear(duration: 1)
                                .speed(0.1).repeatForever(autoreverses: false)) {
                                    isRotating = 360.0
                                }
                        }*/
                }
                .frame(width: geo.size.width/2)
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
