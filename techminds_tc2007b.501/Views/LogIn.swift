//
//  LogIn.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/05/23.
//

import SwiftUI

struct LogIn: View {
    @State private var isRotating = 0.0
    
    @State var correo : String
    @State var contraseña : String
    @State var login : Bool = true
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                ZStack {
                    Rectangle()
                        .fill(.clear)
                        .frame(width: geo.size.width/2)
                    
                    VStack(alignment: .leading,spacing: geo.size.height/30) {
                        Group{
                            Text("¡Hola!")
                                .font(.custom("Comfortaa", size: 72))
                            
                            Text("Inicia sesión para continuar")
                                .font(.custom("Comfortaa", size: 24))
                        }
                        
                        Group{
                            TextFillView(textTitle: "Correo electrónico", variable: $correo, temporalText: "Ingresa tu correo", textFillWidth: geo.size.width/3, textFillHeight: geo.size.height/18)
                            
                            TextFillView(textTitle: "Contraseña", variable: $contraseña, temporalText: "Ingresa tu contraseña", textFillWidth: geo.size.width/3, textFillHeight: geo.size.height/18)
                              
                            ButtonView(action: "", buttonColor: "primary", buttonText: "Iniciar sesión", buttonWidth: geo.size.width/3, buttonHeight: geo.size.height/18)

                        }
                        
                        Group{
                            Button {
                                if login == true {
                                    login = false
                                } else {
                                    login = true
                                }
                            } label: {
                                Text("Olvidé mi contraseña")
                                    .font(.custom("Comfortaa", size: 18))
                                    .foregroundColor(Color("secondary"))
                            }
                            
                            Button {
                                if login == true {
                                    login = false
                                } else {
                                    login = true
                                }
                            } label: {
                                Text("Crear una cuenta")
                                    .font(.custom("Comfortaa", size: 18))
                                    .foregroundColor(Color("secondary"))
                            }
                        }
                    }
                    .frame(width: geo.size.width/2)
                }
                ZStack {
                    Rectangle()
                        .fill(Color("primary lighter"))
                        .frame(width: geo.size.width/2)
                    
                    Image("logo")
                        .resizable()
                        .frame(width: geo.size.width/4,height: geo.size.width/4)
                        .scaledToFill()
                        .rotationEffect(.degrees(isRotating))
                        .onAppear {
                            withAnimation(.linear(duration: 1)
                                .speed(0.1).repeatForever(autoreverses: false)) {
                            isRotating = 360.0
                        }
                    }
                }
            }
        }
    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn(correo: "", contraseña: "", login: true)
    }
}
