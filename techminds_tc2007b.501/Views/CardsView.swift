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
                CardButton(action: "", cardWidth: 350, cardHeight: 350, cardColor: "primary lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, cardTitle: "Perro", titleColor: "primary darker")
                
                CardButton(action: "", cardWidth: 350, cardHeight: 350, cardColor: "accent1 lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, cardTitle: "Perro", titleColor: "accent1 darker")
                
                CardButton(action: "", cardWidth: 350, cardHeight: 350, cardColor: "accent2 lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, cardTitle: "Perro", titleColor: "accent2 darker")
            }
            GridRow {
                CardButton(action: "", cardWidth: 350, cardHeight: 350, cardColor: "secondary lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, cardTitle: "Perro", titleColor: "secondary darker")
                
                CardButton(action: "", cardWidth: 350, cardHeight: 350, cardColor: "accent2 lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, cardTitle: "Perro", titleColor: "accent2 darker")
                
                CardButton(action: "", cardWidth: 350, cardHeight: 350, cardColor: "secondary lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, cardTitle: "Perro", titleColor: "secondary darker")
            }
            GridRow {
                CardButton(action: "", cardWidth: 350, cardHeight: 350, cardColor: "accent1 lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, cardTitle: "Perro", titleColor: "accent1 darker")
                
                CardButton(action: "", cardWidth: 350, cardHeight: 350, cardColor: "primary lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, cardTitle: "Perro", titleColor: "primary darker")
                
                CardButton(action: "", cardWidth: 350, cardHeight: 350, cardColor: "primary lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, cardTitle: "Perro", titleColor: "primary darker")
            }
        }
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
    }
}
