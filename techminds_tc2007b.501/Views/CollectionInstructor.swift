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
    
    //CARD
    @State private var cards: [ExampleCard] = [
        ExampleCard(name: "Coleccion 1", numCards: 5, tOn: false, onLight: false),
        ExampleCard(name: "Coleccion 2", numCards: 3, tOn: false, onLight: false),
        ExampleCard(name: "Coleccion 3", numCards: 2, tOn: false, onLight: false)
    ]
    
    var body: some View {
        GeometryReader { geo in
                HStack {
                    VStack(alignment: .leading, spacing: 32) {
                        Text("Colecciones")
                            .font(.custom("Comfortaa", size: 72))
                            .frame(maxWidth: .infinity, alignment:.topLeading)
                        
                        //Right Side
                        Group{
                            HStack {
                                Text("Nombre")
                                    .font(.custom("Raleway-bold", size: 18))                            .frame(maxWidth: .infinity, alignment: .leading)
                                Text("# de tarjetas")
                                    .font(.custom("Raleway-bold", size: 18))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("Habilitar")
                                    .font(.custom("Raleway-bold", size: 18))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                Text("")
                                    .font(.custom("Raleway-bold", size: 18))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
                            }
                       //     .padding(.horizontal)
                          //  .font(.custom("Raleway-bold", size: 18))
                            
                            ForEach(cards.indices, id: \.self) { index in
                                HStack {
                                    Text(cards[index].name)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(cards[index].numCards)")
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    Toggle("", isOn: $cards[index].tOn)
                                        .onChange(of: cards[index].tOn) { newValue in cards[index] .onLight = newValue
                                        }
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    Circle()
                                        .fill(cards[index].onLight ? Color.green : Color.gray)
                                        .frame(width: 20, height: 20)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                            //    .padding(.horizontal)
                                .font(.custom("Comfortaa", size: 18))                                .padding(.bottom ,10)
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 64, bottom: 0, trailing: 64))
                    .frame(width: geo.size.width/1.7)
                    
                    //Left Side
                    ZStack {
                        Color("white")
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

