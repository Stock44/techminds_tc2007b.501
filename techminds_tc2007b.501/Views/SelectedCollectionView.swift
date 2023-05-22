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
                StudentCards(cardColor: "primary lighter", cardImage: "perro", imageTitle: "perro")
                
                StudentCards(cardColor: "accent1 lighter", cardImage: "perro", imageTitle: "perro")
                
                StudentCards(cardColor: "accent2 lighter", cardImage: "perro", imageTitle: "perro")
            }
            GridRow{
                StudentCards(cardColor: "secondary lighter", cardImage: "perro", imageTitle: "perro")
                
                StudentCards(cardColor: "accent2 lighter", cardImage: "perro", imageTitle: "perro")
                
                StudentCards(cardColor: "secondary lighter", cardImage: "perro", imageTitle: "perro")
            }
            GridRow{
                StudentCards(cardColor: "accent1 lighter", cardImage: "perro", imageTitle: "perro")
                
                StudentCards(cardColor: "primary lighter", cardImage: "perro", imageTitle: "perro")
                
                StudentCards(cardColor: "primary lighter", cardImage: "perro", imageTitle: "perro")
            }
        }.navigationTitle("Colección 1")
    }
}

struct SelectedCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedCollectionView()
    }
}
