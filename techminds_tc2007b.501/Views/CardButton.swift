//
//  CardButton.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI

struct CardButton: View {
    var action : String
    var cardWidth : CGFloat
    var cardHeight : CGFloat
    var cardColor : String
    var cardImage : String
    var imageWidth : CGFloat
    var imageHeight : CGFloat
    var cardTitle : String
    var titleColor : String
    
    var body: some View {
        Button {
            action
        } label: {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: cardWidth, height: cardHeight)
                    .foregroundColor(Color(cardColor))
                VStack {
                    Image(cardImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageWidth, height: imageHeight)
                    Text(cardTitle)
                        .font(.custom("Comfortaa", size: 36))
                        .foregroundColor(Color(titleColor))
                }
            }
        }
    }
}

struct CardButton_Previews: PreviewProvider {
    static var previews: some View {
        CardButton(action: "", cardWidth: 350, cardHeight: 230, cardColor: "primary lighter", cardImage: "perro", imageWidth: 272, imageHeight: 127, cardTitle: "Perro", titleColor: "primary darker")
    }
}
