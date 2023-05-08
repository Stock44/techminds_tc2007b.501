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
    @State var inicio:Bool = true
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                VStack {
                    Text("¡Hola!")
                        .font(.largeTitle)
                        
                    Text("Inicia sesión para continiuar")
                        .font(.title2)
                        .padding()
                    Text("Correo electrónico")
                    TextField("Ingresa tu correo electrónico", text: $correo)
                        .cornerRadius(16)
                        .border(Color.gray)
                        .padding()
                    Text("Contraseña")
                    TextField("Ingresa tu contraseña", text: $contraseña)
                        .border(Color.gray)
                        .padding()
                    Button {
                        if inicio == true {
                            inicio = false
                        } else {
                            inicio = true
                        }
                    } label: {
                        ZStack {
                            Capsule()
                                .fill(.orange)
                                .frame(width: 50, height: geo.size.height/4)
                                .rotationEffect(Angle(degrees: 90))
                            Text("Iniciar sesión")
                        }
                    }
                    Text("Olvidé mi contraseña")
                        .foregroundColor(.orange)
                    Text("Crear cuenta")
                        .foregroundColor(.orange)
                }
                ZStack {
                    Rectangle()
                        .fill(.orange)
                    Image("logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width/6, height: geo.size.height/6)
                }
            }
        }
    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn(correo: "", contraseña: "", inicio: true)
    }
}
