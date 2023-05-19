//
//  AccessibilityConfigView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI

struct AccessibilityConfigView: View {
    
    @State private var boton = false
    @State private var slider = 0.5
    @State private var filas = 1
    @State private var columnas = 1
    
    var body: some View {
            HStack{
                VStack{
                    VStack(spacing: 30){
                        Toggle("Botones", isOn: $boton)
                            .font(.custom("Comfortaa", size: 36))
                        Toggle("Estimación Cabeza", isOn: $boton)
                            .font(.custom("Comfortaa", size: 36))
                        Toggle("VoiceOver", isOn: $boton)
                            .font(.custom("Comfortaa", size: 36))
                        Text("Letra")
                            .font(.custom("Comfortaa", size: 32))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Slider(value: $slider)
                        Text("Botones")
                            .font(.custom("Comfortaa", size: 32))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Slider(value: $slider)
                        Text("Tarjetas")
                            .font(.custom("Comfortaa", size: 32))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Slider(value: $slider)
                    }
                    HStack{
                        Text("Filas")
                            .font(.custom("Comfortaa", size: 24))
                        Picker("Filas",selection: $filas){
                            ForEach(1..<10, id: \.self){
                                Text("\($0)")
                            }
                        }
                        .frame(width: 161 , height: 67)
                        .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                        Spacer()
                        Text("Columnas")
                            .font(.custom("Comfortaa", size: 24))
                        Picker("Columnas",selection: $columnas){
                            ForEach(1..<10, id: \.self){
                                Text("\($0)")
                            }
                        }
                        .frame(width: 161 , height: 67)
                        .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                    }
                }
                .padding(.leading, 40.0)
                VStack{
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color.white)
                        Rectangle()
                            .frame(width: 350, height: 609)
                            .cornerRadius(20)
                            .foregroundColor(Color("accent2 lighter"))
                        VStack{
                            Text("Letra")
                                .font(.custom("Comfortaa", size: 100*slider))
                            Image("logo")
                                .resizable()
                                .frame(width: 300 * slider, height: 300 * slider)
                        }
                    }
                }
            }.navigationTitle("Accesibilidad")
        }
}



struct AccessibilityConfigView_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityConfigView()
    }
}
