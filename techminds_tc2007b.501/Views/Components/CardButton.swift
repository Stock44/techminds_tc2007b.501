//
//  CardButton.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI

struct CardButton: View {
    var action : String
    var cardColor : String
    var cardImage : String
    var cardTitle : String
    var titleColor : String
    
    var body: some View {
        Button {
        } label: {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(Color(cardColor))
                VStack {
                    Image(cardImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        CardButton(action: "", cardColor: "primary lighter", cardImage: "perro", cardTitle: "Perro", titleColor: "primary darker")
    }
}
