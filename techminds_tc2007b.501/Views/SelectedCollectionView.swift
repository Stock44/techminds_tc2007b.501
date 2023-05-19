//
//  SelectedCollectionView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI

struct SelectedCollectionView: View {
    var body: some View {
        Grid {
            GridRow {
                StudentCards(cardWidth: 350, cardHeight: 350, cardColor: "primary lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, imageTitle: "perro")
                
                StudentCards(cardWidth: 350, cardHeight: 350, cardColor: "accent1 lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, imageTitle: "perro")
                
                StudentCards(cardWidth: 350, cardHeight: 350, cardColor: "accent2 lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, imageTitle: "perro")
            }
            GridRow{
                StudentCards(cardWidth: 350, cardHeight: 350, cardColor: "secondary lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, imageTitle: "perro")
                
                StudentCards(cardWidth: 350, cardHeight: 350, cardColor: "accent2 lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, imageTitle: "perro")
                
                StudentCards(cardWidth: 350, cardHeight: 350, cardColor: "secondary lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, imageTitle: "perro")
            }
            GridRow{
                StudentCards(cardWidth: 350, cardHeight: 350, cardColor: "accent1 lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, imageTitle: "perro")
                
                StudentCards(cardWidth: 350, cardHeight: 350, cardColor: "primary lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, imageTitle: "perro")
                
                StudentCards(cardWidth: 350, cardHeight: 350, cardColor: "primary lighter", cardImage: "perro", imageWidth: 334, imageHeight: 334, imageTitle: "perro")
            }
        }.navigationTitle("Colección 1")
    }
}

struct SelectedCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedCollectionView()
    }
}
