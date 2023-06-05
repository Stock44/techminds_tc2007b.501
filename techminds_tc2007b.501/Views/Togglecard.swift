//
//  Tarjeta.swift
//  techminds_tc2007b.501
//
//  Created by Andrea Garza on 26/05/23.
//

import SwiftUI

struct ExampleCard {
    let name: String
    let numCards: Int
    var tOn: Bool
    var onLight: Bool
}

struct CardView: View {
    @State private var cards: [ExampleCard] = [
        ExampleCard(name: "Tarjeta 1", numCards: 5, tOn: false, onLight: false),
        ExampleCard(name: "Tarjeta 2", numCards: 3, tOn: false, onLight: false),
        ExampleCard(name: "Tarjeta 3", numCards: 2, tOn: false, onLight: false)
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
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
