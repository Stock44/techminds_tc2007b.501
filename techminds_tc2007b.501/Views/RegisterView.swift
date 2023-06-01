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
    
    @State private var nombre: String = ""
    @State private var apellido: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordValidation: String = ""
    
    @State var errorMsg: String? = nil
    
    func onRegister() async {
        if password != passwordValidation {
            withAnimation {
                errorMsg = "Las contraseñas no coinciden."
            }
            return
        }
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
        } catch AuthErrorCode.operationNotAllowed {
            withAnimation {
                errorMsg = "El inicio de sesión esta desactivado."
            }
        } catch AuthErrorCode.emailAlreadyInUse {
            withAnimation {
                errorMsg = "Este correo electronico ya esta en uso."
            }
        } catch AuthErrorCode.weakPassword {
            withAnimation {
                errorMsg = "Contraseña debil."
            }
        } catch AuthErrorCode.invalidEmail {
            withAnimation {
                errorMsg = "Correo electronico invalido."
            }
        } catch {
            withAnimation {
                errorMsg = "Ha ocurrido un error desconocido."
            }
        }
    }
    
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
                            LabelledPasswordBox(label: "Contraseña", placeholder: "Ingresa una contraseña", content: $password)
                            LabelledPasswordBox(label: "Confirma tu contraseña", placeholder: "Ingresa la misma contraseña", content: $passwordValidation)
                            FilledButton(labelText: "Registrarse") {
                                Task {
                                    await onRegister()
                                }
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
            .overlay(alignment: .bottomLeading){
                if let errorMsg = errorMsg {
                    ErrorPopup(label: errorMsg)
                        .offset(x: 32, y: -8)
                        .transition(.move(edge: .leading))
                        .task {
                            try? await Task.sleep(for: .seconds(4))
                            withAnimation {
                                self.errorMsg = nil
                            }
                        }
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
