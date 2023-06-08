//
//  CollectionDisplay.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 07/06/23.
//

import SwiftUI

struct CollectionDisplayView: View {
    @StateObject var viewModel: CollectionViewModel
    
    var body: some View {
        Text(viewModel.collection.name)
            .typography(.title)
            .foregroundColor(Color(cgColor: viewModel.collection.color.cgColor))
            .colorInvert()
            .contrast(3.5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(cgColor: viewModel.collection.color.cgColor))
            .cornerRadius(16)
    }
}

struct CollectionDisplay_Previews: PreviewProvider {
    static var previews: some View {
        Text("Test")
    }
}
