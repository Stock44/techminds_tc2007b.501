//
//  CardsConfig.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 26/05/23.
//

import SwiftUI

struct InstructorCardsView: View {
    @State var isEditing = false
    @State var editViewModel: CardViewModel?
    @StateObject private var viewModel = CardListViewModel()
    var body: some View {
        List {
            HStack(alignment: .center, spacing: 32) {
                Spacer(minLength: 32)
                Text("Nombre")
                    .font(.custom("Raleway-bold", size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("# de tarjetas")
                    .font(.custom("Raleway-bold", size: 18))
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Habilitar")
                    .font(.custom("Raleway-bold", size: 18))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text("")
                    .font(.custom("Raleway-bold", size: 18))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            
            ForEach(viewModel.cardViewModels) { card in
                HStack(alignment: .center, spacing: 32) {
                    Text(card.card.name)
                    
                    Button {
                        editViewModel = card
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .navigationTitle("Editar tarjetas")
        .toolbar {
            ToolbarItemGroup (placement: .navigationBarTrailing) {
                Button {
                    editViewModel =  CardViewModel()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }.sheet(isPresented: Binding(get: {editViewModel != nil}, set: {value in if !value {editViewModel = nil}})) {
            CardEditView(viewModel: editViewModel!)
        }
    }
}

struct InstructorCardsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructorCardsView()
    }
}
