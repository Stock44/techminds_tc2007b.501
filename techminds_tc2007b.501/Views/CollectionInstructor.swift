//
//  CollectionInstructor.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 22/05/23.
//

import SwiftUI
import FirebaseAuth

struct CollectionInstructor: View {
    
    @State private var bgColor = Color.blue
    
    @State var name : String = ""
    @State var contraseña : String = ""
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                VStack(alignment: .leading, spacing: 32) {
                    Text("Colecciones")
                        .font(.custom("Comfortaa", size: 72))
                    
                    
                    Group {
        
                        
                        LabelledTextBox(label: "Contraseña", placeholder: "Ingresa tu contraseña", content: $contraseña)
                        
                        FilledButton(labelText: "Iniciar sesión") {
                            
                        }
                        
                    }.frame(maxWidth: 512)
                    
                }
                .padding(EdgeInsets(top: 0, leading: 64, bottom: 0, trailing: 64))
                .frame(width: geo.size.width/1.7)
                ZStack {
                    Color("primary lighter")
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(alignment: .leading, spacing: 8){
                        
                        Group{
                            LabelledTextBox(label: "Nombre", placeholder: "Ingresa el nombre de la Coleccion", content: $name)
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                            
                            Text("Color")
                                .font(.custom("Comfortaa", size: 16))
                                .frame(width: 100, height: 20,alignment: .leading)

                            
                            ColorPicker("", selection: $bgColor, supportsOpacity: false)
                                .frame(width: 300, height: 20)
                                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                                .background(bgColor)
                                .cornerRadius(16)
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))

                            
                            FilledButton(labelText: "Confirmar"){}
                                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                            
                            FilledButton(labelText: "Ver Tarjetas"){}
                        }
                    }
                    .frame(maxWidth: 512)
                    //.frame(width: geo.size.width/2)
                }
            }
        }
    }
}

struct CollectionInstructor_Previews: PreviewProvider {
    static var previews: some View {
        CollectionInstructor()
    }
}

