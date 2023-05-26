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
    
    @State var correo : String = ""
    @State var contraseña : String = ""
    @State var errorMsg: String? = nil
    
    func onLogin() async {
        do {
            try await Auth.auth().signIn(withEmail: correo, password: contraseña)
        } catch AuthErrorCode.operationNotAllowed {
            withAnimation {
                errorMsg = "El inicio de sesión esta desactivado."
            }
        } catch AuthErrorCode.userDisabled {
            withAnimation {
                errorMsg = "Este usuario esta desactivado."
            }
        } catch AuthErrorCode.wrongPassword {
            withAnimation {
                errorMsg = "Contraseña incorrecta."
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
                        Group {
                            LabelledTextBox(label: "Correo electrónico", placeholder: "Ingresa tu correo", content: $correo)
                            
                            LabelledTextBox(label: "Contraseña", placeholder: "Ingresa tu contraseña", content: $contraseña)
                            FilledButton(labelText: "Iniciar sesión") {
                                Task {
                                    await onLogin()
                                    
                                }
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

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
