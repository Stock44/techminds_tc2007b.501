//
//  CollectionButton.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI

struct CollectionButton: View {
    var action : String
    var collectionColor : String
    var collectionTitle : String
    var titleColor : String
    
    var body: some View {
        NavigationLink {
            SelectedCollectionView()
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        CollectionButton(action: "", collectionColor: "accent1 lighter", collectionTitle: "Lorem ipsum", titleColor: "accent1 darker")
    }
}
