//
//  RegisterView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/05/23.
//

import SwiftUI

struct RegisterView: View {
    @State private var nombre: String = ""
    @State private var apellido: String = ""
    @State private var email: String = ""
    @State private var contrasena: String = ""
    @State private var valcontrasena: String = ""
    
    @State private var nivel: Int = 1
    let nivelesDisponibles = Array(1...4)
    
    var body: some View {
        GeometryReader { geo in
        
            // Botón de regreso
            Button(action: {
                // Acción de regreso
            }, label: {
                Image(systemName: "arrow.backward")
            })
            
            Text("Registro de Usuario")
                .font(.custom("Comfortaa-Light", size: 72))
                .padding()
            
            HStack {
                VStack  {
                    HStack{
                        VStack (alignment:.leading, spacing: 6) {
                            // NOMBRE
                            Text("Nombre(s) del alumno")
                                .font(.custom("Raleway", size: 18))
                            TextField("Ingresa el nombre(s) del alumno", text: $nombre)
                                .padding()
                                .frame(width: 400, height: 40)
                                .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))                                .padding(.bottom, 20)
                        }
                        VStack (alignment:.leading, spacing: 6) {
                            //APELLIDO
                            Text("Apellido(s) del alumno")
                                .font(.custom("Raleway", size: 18))
                            TextField("Ingresa el apellido(s) del alumno", text: $apellido)
                                .padding()
                                .frame(width: 400, height: 40)
                                .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                .padding(.bottom, 20)
                        }
                    }
                    HStack{
                        VStack(alignment:.leading, spacing: 6){
                            //CORREO
                            Text("Correo Electronico")
                                .font(.custom("Raleway", size: 18))
                            TextField("Ingresa tu correo electronico", text: $email)
                                .padding()
                                .frame(width: 550, height: 40)
                                .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                .padding(.bottom, 20)

                        }
                        VStack (alignment:.leading, spacing: 6){
                            // NIVEL
                            Text("Nivel")
                                .font(.custom("Raleway", size: 18))
                            Picker("Nivel", selection: $nivel) {
                                ForEach(nivelesDisponibles, id: \.self) { nivel in
                                    Text("Nivel \(nivel)")
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                            .frame(width: 250, height: 40)

                        }
                        
                        
                    }
                    
                    VStack (alignment:.leading, spacing: 6){
                        
                        Text("Contraseña")
                            .font(.custom("Raleway", size: 18))
                        SecureField("Ingresa tu contraseña", text: $contrasena)
                            .padding()
                            .frame(width: 800, height: 40)
                            .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                            .padding(.bottom, 20)
                    }
                    
                    VStack(alignment:.leading, spacing: 6){
                        Text("Confirmacion de Contraseña")
                            .font(.custom("Raleway", size: 18))
                        SecureField("Ingresa tu contraseña de nuevo", text: $valcontrasena)
                            .padding()
                            .frame(width: 800, height: 40)
                            .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                            .padding(.bottom, 24)
                    }
                        
                        // Botón de registro
                        Button(action: {
                            // Acción de registro
                        }, label: {
                            Text("Confirmar Datos")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 780, height: 60)
                                .background(Color("primary"))
                                .cornerRadius(15.0)
                        })
                    
                }
                .padding()
               
                ZStack{
                    
                    Color("primary lighter")
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geo.size.width/2, height: geo.size.height/1)
                    
                    // Logo o imagen de la app
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/5, height: geo.size.height/2,alignment: .center)
                        .background(Color("primary lighter").edgesIgnoringSafeArea(.all))
                        .animation(.easeInOut, value: 0.4)
                    
                  
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
