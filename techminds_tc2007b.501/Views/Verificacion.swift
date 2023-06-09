//
//  Verificacion.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 07/06/23...
//

import SwiftUI

struct Verificacion: View {
    
    @State var resultado = ""
    
    var body: some View {
        HStack{
            Text("5 x 8 = ")
                .font(.custom("Comfortaa", size: 46))
            TextField("Resultado", text: $resultado)
                .textFieldStyle(.roundedBorder)
                .frame(width: 200)
        }
        .navigationTitle("Completa la operacion para continuar")
    }
}

struct Verificacion_Previews: PreviewProvider {
    static var previews: some View {
        Verificacion()
    }
}
