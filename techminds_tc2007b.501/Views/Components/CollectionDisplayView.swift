//
//  CollectionDisplay.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 07/06/23.
//

import SwiftUI

struct CollectionDisplayView: View {
    var name: String
    var color: Color
    
    var body: some View {
        Text(name)
            .typography(.largeTitle)
            .foregroundColor(color)
            .colorInvert()
            .contrast(3.5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color)
            .cornerRadius(16)
    }
}

struct CollectionDisplay_Previews: PreviewProvider {
    static var previews: some View {
        CollectionDisplayView(name: "Collection", color: .red)
    }
}
