//
//  LogIn.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/05/23.
//

import SwiftUI
import FirebaseAuth

struct LogInView: View {
    @State private var isRotating = 0.0
    
    @State var email : String = ""
    @State var password : String = ""
    @State var errorText: String?
    
    @StateObject private var viewModel = ViewModel()
    
    func rotarImagen() {
        withAnimation(.linear(duration: 1)
            .speed(0.1)
            .repeatForever(autoreverses: false)) {
                isRotating = 360.0
            }
    }
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        Text("¡Hola!")
                            .font(.custom("Comfortaa", size: 72))
                        
                        Text("Inicia sesión para continuar")
                            .font(.custom("Comfortaa", size: 24))
                        if let authError = viewModel.authError {
                            Text(authError.localizedDescription)
                                .typography(.callout)
                                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(Color("primary"))
                                .cornerRadius(16)
                        }
                        Group {
                            LabelledTextBox(label: "Correo electrónico", placeholder: "Ingresa tu correo", content: $email)
                            
                            LabelledTextBox(label: "Contraseña", placeholder: "Ingresa tu contraseña", content: $password)
                            FilledButton(labelText: "Iniciar sesión") {
                                viewModel.login(email: email, password: password)
                            }
                        }.frame(maxWidth: 512)
                        
                        Button {
                            // TODO implement login via firebase auth
                        } label: {
                            Text("Olvidé mi contraseña")
                                .font(.custom("Comfortaa", size: 18))
                                .foregroundColor(Color("secondary"))
                        }
                        Button {
                            // TODO implement login via firebase auth
                        } label: {
                            NavigationLink {
                                RegisterView()
                            } label: {
                                Text("Crear una cuenta")
                                    .font(.custom("Comfortaa", size: 18))
                                    .foregroundColor(Color("secondary"))
                            }
                        }
                    }
                    .offset(y: geo.size.height/6)
                    .padding(EdgeInsets(top: 0, leading: 64, bottom: 0, trailing: 64))
                    .frame(width: geo.size.width / 2)
                }
                .animation(.easeIn(duration: 0.3))
                ZStack {
                    Color("primary lighter")
                        .edgesIgnoringSafeArea(.all)
                    Image("logo")
                        .resizable()
                        .frame(width: geo.size.width/4, height: geo.size.width/4)
                        .scaledToFill()
                        .rotationEffect(.degrees(isRotating))
                        .onAppear {
                            rotarImagen()
                        }
                }
                .frame(width: geo.size.width/2)
            }
            .overlay(alignment: .bottomLeading){
            }
        }
    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
