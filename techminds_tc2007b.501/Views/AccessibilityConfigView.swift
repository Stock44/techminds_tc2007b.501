//
//  AccessibilityConfigView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI

struct AccessibilityConfigView: View {
    
    @State private var botones : Bool = false
    @State private var estcabeza : Bool = false
    @State private var voiceover : Bool = false
    @State private var letratam : Double = 1.0
    @State private var botontam : Double = 0.6
    @State private var tarjetatam : Double = 0.6
    @State private var filas : Int = 1
    @State private var columnas : Int = 1
    
    var body: some View {
            DynamicStack{
                VStack{
                    VStack(spacing: 32){
                        Toggle("Botones", isOn: $botones)
                            .font(.custom("Comfortaa", size: 36))
                        Toggle("Estimación Cabeza", isOn: $estcabeza)
                            .font(.custom("Comfortaa", size: 36))
                        Toggle("VoiceOver", isOn: $voiceover)
                            .font(.custom("Comfortaa", size: 36))
                        Text("Letra")
                            .font(.custom("Comfortaa", size: 32))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Slider(value: $letratam,in: 0.5...3)
                        Text("Botones")
                            .font(.custom("Comfortaa", size: 32))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Slider(value: $botontam, in: 0.2...1)
                        Text("Tarjetas")
                            .font(.custom("Comfortaa", size: 32))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Slider(value: $tarjetatam, in: 0.2...1)
                    }
                    
                    HStack {
                        Text("Filas")
                            .font(.custom("Comfortaa", size: 24))
                        Picker("Filas",selection: $filas){
                            ForEach(1..<10, id: \.self){
                                Text("\($0)")
                            }
                        }
                        .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                        Spacer()
                        Text("Columnas")
                            .font(.custom("Comfortaa", size: 24))
                        Picker("Columnas",selection: $columnas){
                            ForEach(1..<10, id: \.self){
                                Text("\($0)")
                            }
                        }
                        .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                    }
                }
                .padding()
                ZStack{
                    RoundedRectangle(cornerRadius: 16)
                        .frame(maxWidth: 350, maxHeight: 609)
                        .foregroundColor(Color("accent2 lighter"))
                    VStack{
                        Text("Letra")
                            .font(.custom("Comfortaa", size: 36*letratam))
                        Image("logo")
                            .resizable()
                            .frame(width: 300 * tarjetatam, height: 300 * tarjetatam)
                    }
                }
        }
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        .frame(maxWidth: .infinity)
        .navigationTitle("Accesibilidad")
    }
}



struct AccessibilityConfigView_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityConfigView()
    }
}
