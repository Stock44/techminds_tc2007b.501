//
//  CollectionButton.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI

struct CollectionButton: View {
    var action : String
    var collectionWidth : CGFloat
    var collectionHeight : CGFloat
    var collectionColor : String
    var collectionTitle : String
    var titleColor : String
    
    
    var body: some View {
        Button {
            action
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: collectionWidth, height: collectionHeight)
                    .foregroundColor(Color(collectionColor))
                Text(collectionTitle)
                    .font(.custom("Comfortaa", size: 36))
                    .foregroundColor(Color(titleColor))
            }
                
        }
    }
}

struct CollectionButton_Previews: PreviewProvider {
    static var previews: some View {
        CollectionButton(action: "", collectionWidth: 350, collectionHeight: 230, collectionColor: "accent1 lighter", collectionTitle: "Lorem ipsum", titleColor: "accent1 darker")
    }
}
