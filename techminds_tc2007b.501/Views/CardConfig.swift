//
//  CardConfig.swift
//  techminds_tc2007b.501
//
//  Created by Elena Ballinas on 26/05/23.
//

import SwiftUI

struct CardConfig: View {
    @State private var bgColor = Color.blue
    
    @State var name : String = ""
    @State var contraseña : String = ""
    @State var busqueda : String = ""
    @State var toggle = true
    @State var confirmar = true
    
    var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 32) {
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 36))
                            .foregroundColor(Color("primary"))
                        LabelledTextBox(label: "", placeholder: "Buscar", content: $name)
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                    }
                    HStack{
                        Text("Configuraciones")
                            .font(.custom("Raleway", size: 26))
                    }
                    HStack{
                        Text("Setting 1")
                            .font(.custom("Raleway", size: 16))
                        Toggle("", isOn: $toggle)
                    }
                    HStack{
                        Text("Setting 2")
                            .font(.custom("Raleway", size: 16))
                        Toggle("", isOn: $toggle)
                    }
                    HStack{
                        Text("Setting 3")
                            .font(.custom("Raleway", size: 16))
                        Toggle("", isOn: $toggle)
                    }
                    HStack{
                        Text("Setting 4")
                            .font(.custom("Raleway", size: 16))
                        Toggle("", isOn: $toggle)
                    }
                    HStack{
                        Text("Setting 5")
                            .font(.custom("Raleway", size: 16))
                        Toggle("", isOn: $toggle)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 64, bottom: 0, trailing: 64))
                .frame(maxWidth: .infinity)
                    VStack(alignment: .leading, spacing: 8){
                        Image("Imagen")
                        LabelledTextBox(label: "Nombre", placeholder: "Nombre de Imagen", content: $name)
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                        FilledButton(labelText: "Confirmar") {
                            confirmar = false
                        }
                    }
                    .frame(maxWidth: .infinity)
            }.navigationTitle("Todas las tarjetas")
    }
        
}
    


struct CardConfig_Previews: PreviewProvider {
    static var previews: some View {
        CardConfig()
    }
}
