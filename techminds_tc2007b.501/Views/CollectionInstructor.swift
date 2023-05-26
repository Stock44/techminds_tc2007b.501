//
//  CollectionInstructor.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 22/05/23.
//

import SwiftUI

struct CollectionInstructor: View {
    
    @State private var bgColor = Color.indigo
    
    @State var name : String = ""
    @State var contraseña : String = ""
    
    //CARD
    @State private var cards: [Card] = [
        Card(name: "Tarjeta 1", numCards: 5, tOn: false, onLight: false),
        Card(name: "Tarjeta 2", numCards: 3, tOn: false, onLight: false),
        Card(name: "Tarjeta 3", numCards: 2, tOn: false, onLight: false)
    ]
    
    var body: some View {
        GeometryReader { geo in
                HStack {
                    VStack(alignment: .leading, spacing: 32) {
                        Text("Colecciones")
                            .font(.custom("Comfortaa", size: 72))
                        
                        //Right Side
                        Group{
                            HStack {
                                Text("Nombre")
                                Spacer()
                                Spacer()
                                Text("# de tarjetas")
                                Spacer()
                                Spacer()
                                Text("Habilitar")
                                
                            }
                            .padding(.horizontal)
                            .font(.headline)
                            
                            ForEach(cards.indices, id: \.self) { index in
                                HStack {
                                    Text(cards[index].name)
                                    Spacer()
                                    Text("\(cards[index].numCards)")
                                    Spacer()
                                    Toggle("", isOn: $cards[index].tOn)
                                        .onChange(of: cards[index].tOn) { newValue in cards[index] .onLight = newValue
                                        }
                                    Spacer()
                                    Circle()
                                        .fill(cards[index].onLight ? Color.green : Color.gray)
                                        .frame(width: 20, height: 20)
                                }
                                .padding(.horizontal)
                                .font(.body)
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 64, bottom: 0, trailing: 64))
                    .frame(width: geo.size.width/1.7)
                    
                    //Left Side
                    ZStack {
                        Color("primary lighter")
                            .edgesIgnoringSafeArea(.all)
                        
                        VStack(alignment: .leading, spacing: 8){
                            
                            Group{
                                LabelledTextBox(label: "Nombre", placeholder: "Ingresa el nombre de la Coleccion", content: $name)
                                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 45, trailing: 16))
                                
                                Text("   Color")
                                    .font(.custom("Comfortaa-regular", size: 16))
                                    .frame(width: 100, height: 20,alignment: .leading)
                                
                                
                                ColorPicker("", selection: $bgColor, supportsOpacity: false)
                                    .frame(width: 445, height: 30)
                                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                                    .background(bgColor)
                                    .cornerRadius(16)
                                    .frame(width: 500)
                                // .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                                
                                
                                FilledButton(labelText: "Confirmar"){}
                                    .padding(EdgeInsets(top: 70, leading: 16, bottom: 16, trailing: 16))
                                
                                FilledButton(labelText: "Ver Tarjetas"){}
                                    .padding(EdgeInsets(top: 70, leading: 16, bottom: 16, trailing: 16))
                                
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

