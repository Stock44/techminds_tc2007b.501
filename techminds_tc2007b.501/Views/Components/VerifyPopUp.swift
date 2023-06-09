//
//  VerifyPopUp.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 31/05/23.
//

import SwiftUI

struct VerifyPopUp: View {
    @State var contraseña : String = ""
    @State var contraseña2 : String = "hola"
    @State var error : Bool  = false
    
    var body: some View {
        VStack(spacing: 32){
            Text("Ingresa tu contraseña para realizar cambios a esta cuenta")
                .font(.custom("Comfortaa",size: 24))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            SecureField("Contraseña", text: $contraseña)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                .border(Color.black, width: 0.1)
                .background(Color("accent1 lighter"))
                .padding(.horizontal, 70.0)
            
                FilledButton(labelText: "Aceptar"){
                    if contraseña == contraseña2 {
                        print("Hola")
                    }
                    else{
                        error = true
                    }
                }
                .background(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 1))
                .alert(isPresented: $error){
                    Alert(
                        title: Text("Error de contraseña"),
                        message: Text( "Contraseña incorrecta")
                    )
                }
            .frame(maxWidth: 200)
        }
        .padding(.all, 16.0)
        .frame(maxWidth: .infinity, maxHeight: 432)
        .background(Color("primary"))
    }
}

struct VerifyPopUp_Previews: PreviewProvider {
    static var previews: some View {
        VerifyPopUp()
    }
}
