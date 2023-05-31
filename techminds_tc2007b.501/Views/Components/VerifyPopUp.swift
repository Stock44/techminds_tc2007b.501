//
//  VerifyPopUp.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 31/05/23.
//

import SwiftUI

struct VerifyPopUp: View {
    @State var contraseña = ""
    @State var contraseña2 = "hola"
    @State var error = false
    
    var body: some View {
        VStack(spacing: 50){
            Text("Ingresa tu contraseña para realizar cambios a esta cuenta")
                .font(.custom("Comfortaa",size: 24))
            SecureField("Contraseña",text: $contraseña)
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
                .alert(isPresented: $error){
                    Alert(
                        title: Text("Error de contraseña"),
                        message: Text( "Contraseña incorrecta")
                    )
                }
            .frame(maxWidth: 200)
        }
        .frame( width: 767, height: 432)
        .background(Color("primary lighter"))
    }
}

struct VerifyPopUp_Previews: PreviewProvider {
    static var previews: some View {
        VerifyPopUp()
    }
}
