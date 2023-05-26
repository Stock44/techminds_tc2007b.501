//
//  Tarjeta.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 26/05/23.
//

import SwiftUI

struct Card {
    let nombre: String
    let numTarjetas: Int
    var habilitado: Bool
    var enFoco: Bool
}

struct CardView: View {
    @State private var cards: [Card] = [
        Card(nombre: "Tarjeta 1", numTarjetas: 5, habilitado: false, enFoco: false),
        Card(nombre: "Tarjeta 2", numTarjetas: 3, habilitado: false, enFoco: false),
        Card(nombre: "Tarjeta 3", numTarjetas: 2, habilitado: false, enFoco: false)
    ]

    var body: some View {
        VStack {
            HStack {
                Text("Nombre")
                Spacer()
                Text("# de tarjetas")
                Spacer()
                Text("Habilitar")
                Spacer()
                Text("")
            }
            .padding(.horizontal)
            .font(.headline)

            ForEach(cards.indices, id: \.self) { index in
                HStack {
                    Text(cards[index].nombre)
                    Spacer()
                    Text("\(cards[index].numTarjetas)")
                    Spacer()
                    Toggle("", isOn: $cards[index].habilitado)
                        .onChange(of: cards[index].habilitado) { newValue in cards[index] .enFoco = newValue
                            
                        }
                    Spacer()
                    Circle()
                        .fill(cards[index].enFoco ? Color.green : Color.gray)
                        .frame(width: 20, height: 20)
                }
                .padding(.horizontal)
                .font(.body)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
