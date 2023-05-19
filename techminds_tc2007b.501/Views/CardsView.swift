//
//  CardsView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI

struct CardsView: View {
    var body: some View {
        Grid {
            GridRow {
                CardButton(action: "", cardWidth: 350, cardHeight: 270, cardColor: "primary lighter", cardImage: "perro", imageWidth: 320, imageHeight: 200, cardTitle: "Perro", titleColor: "primary darker")
                
                CardButton(action: "", cardWidth: 350, cardHeight: 270, cardColor: "accent1 lighter", cardImage: "perro", imageWidth: 320, imageHeight: 200, cardTitle: "Perro", titleColor: "accent1 darker")
                
                CardButton(action: "", cardWidth: 350, cardHeight: 270, cardColor: "accent2 lighter", cardImage: "perro", imageWidth: 320, imageHeight: 200, cardTitle: "Perro", titleColor: "accent2 darker")
            }
            GridRow {
                CardButton(action: "", cardWidth: 350, cardHeight: 270, cardColor: "secondary lighter", cardImage: "perro", imageWidth: 320, imageHeight: 200, cardTitle: "Perro", titleColor: "secondary darker")
                
                CardButton(action: "", cardWidth: 350, cardHeight: 270, cardColor: "accent2 lighter", cardImage: "perro", imageWidth: 320, imageHeight: 200, cardTitle: "Perro", titleColor: "accent2 darker")
                
                CardButton(action: "", cardWidth: 350, cardHeight: 270, cardColor: "secondary lighter", cardImage: "perro", imageWidth: 320, imageHeight: 200, cardTitle: "Perro", titleColor: "secondary darker")
            }
            GridRow {
                CardButton(action: "", cardWidth: 350, cardHeight: 270, cardColor: "accent1 lighter", cardImage: "perro", imageWidth: 320, imageHeight: 200, cardTitle: "Perro", titleColor: "accent1 darker")
                
                CardButton(action: "", cardWidth: 350, cardHeight: 270, cardColor: "primary lighter", cardImage: "perro", imageWidth: 320, imageHeight: 200, cardTitle: "Perro", titleColor: "primary darker")
                
                CardButton(action: "", cardWidth: 350, cardHeight: 270, cardColor: "primary lighter", cardImage: "perro", imageWidth: 320, imageHeight: 200, cardTitle: "Perro", titleColor: "primary darker")
            }
        }.navigationTitle("Tarjetas")
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
    }
}
