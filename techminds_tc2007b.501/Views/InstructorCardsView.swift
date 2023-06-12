//
//  CardsConfig.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 26/05/23.
//

import SwiftUI

struct InstructorCardsView: View {
    @State private var isEditing = false
    @State private var isCreating = false
    @State private var editViewModel: CardEditingViewModel?
    @StateObject private var viewModel = CardListViewModel()
    
    var body: some View {
        List {
            HStack(alignment: .center, spacing: 32) {
                Spacer(minLength: 32)
                Text("Nombre")
                    .font(.custom("Raleway-bold", size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("")
                    .font(.custom("Raleway-bold", size: 18))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            
            ForEach([CardViewModel](viewModel.cardViewModels)) { card in
                HStack(alignment: .center, spacing: 32) {
                    Text(card.card.name)
                    
                    Button {
                        editViewModel = CardEditingViewModel(card: card.card)
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .navigationTitle("Editar tarjetas")
        .onAppear {
            viewModel.getAll()
        }
        .toolbar {
            ToolbarItemGroup (placement: .navigationBarTrailing) {
                Button {
                    isCreating = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }.sheet(isPresented: Binding(get: {editViewModel != nil}, set: {value in if !value {editViewModel = nil}})) {
            CardEditView(viewModel: editViewModel!)
        }
        .sheet(isPresented: $isCreating) {
            CardCreationView()
        }
    }
}

struct InstructorCardsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructorCardsView()
    }
}
