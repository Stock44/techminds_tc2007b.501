//
//  CollectionLinkView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 12/06/23.
//

import SwiftUI

struct CollectionLinkView: ViewModelView {
    typealias ViewModel = CollectionViewModel
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationLink {
            StudentCollectionCardsView(viewModel: viewModel)
        } label: {
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
}

struct CollectionLink_Previews: PreviewProvider {
    @StateObject static var viewModel = CollectionViewModel(collection: Collection())
    static var previews: some View {
        CollectionDisplayView(viewModel: viewModel)
    }
}

