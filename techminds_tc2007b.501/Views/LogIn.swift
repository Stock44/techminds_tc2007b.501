//
//  LogIn.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/05/23.
//

import SwiftUI

struct LogIn: View {
    @State var correo:String
    @State var contraseña:String
    @State var login:Bool
    
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
                            Text("Correo electrónico")
                                .font(.custom("Comfortaa", size: 16))
                            
                            TextField(text: $correo) {
                                    Text("Ingresa tu correo electrónico")
                                    .font(.custom("Raleway", size: 18))
                                }
                            .frame(width: geo.size.width/3, height: geo.size.height/18)
                            .offset(x: 20)
                            .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                            
                            Text("Contraseña")
                                .font(.custom("Comfortaa", size: 16))
                            
                            TextField(text: $contraseña) {
                                    Text("Ingresa tu contraseña")
                                    .font(.custom("Raleway", size: 18))
                                }
                            .frame(width: geo.size.width/3, height: geo.size.height/18)
                            .offset(x: 20)
                            .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                              
                            //ButtonView({}, buttonColor: "primary", buttonText: "Iniciar sesión", buttonWidth: geo.size.width/3, buttonHeight: geo.size.height/18)
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
