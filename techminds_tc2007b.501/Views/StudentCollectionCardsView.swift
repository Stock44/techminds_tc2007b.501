//
//  StudentCollectionCardsView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 09/06/23.
//

import SwiftUI

struct StudentCollectionCardsView: View {
    @ObservedObject var viewModel = CollectionViewModel()
    
    var body: some View {
        UserGrid<CardViewModel, CardView>(viewModels: [CardViewModel](viewModel.cards))
            .navigationTitle(viewModel.collection.name)
            .onAppear {
                viewModel.getCards()
            }
    }
}

struct StudentCollectionCardsView_Previews: PreviewProvider {
    static var previews: some View {
        StudentCollectionCardsView()
    }
}
