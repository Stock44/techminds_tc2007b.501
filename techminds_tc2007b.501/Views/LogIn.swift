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
                                .font(.largeTitle)
                            
                            Text("Inicia sesión para continuar")
                                .font(.title2)
                        }
                        Group{
                            Text("Correo electrónico")
                            
                            TextField(text: $correo) {
                                    Text("Ingresa tu correo electrónico")
                                }
                            .frame(width: geo.size.width/3, height: geo.size.height/18)
                            .overlay{RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.gray)
                            }
                            
                            Text("Contraseña")
                            
                            TextField(text: $contraseña) {
                                    Text("Ingresa tu contraseña")
                                }
                            .frame(width: geo.size.width/3, height: geo.size.height/18)
                            .overlay{RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.gray)
                            }
                                
                            Button {
                                if login == true {
                                    login = false
                                } else {
                                    login = true
                                }
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .fill(Color("primary"))
                                        .frame(width: geo.size.width/3, height: geo.size.height/18)
                                        .cornerRadius(16)
                                    
                                    Text("Iniciar sesión")
                                        .foregroundColor(.white)
                                }
                            }
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
