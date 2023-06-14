//
//  CardEditView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/06/23.
//

import SwiftUI
import PhotosUI

struct CardEditView: View {
    @ObservedObject var viewModel: CardEditingViewModel
    
    @State private var showDelete: Bool = false
    @State private var imageSelection: PhotosPickerItem?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32){
            CardView(viewModel: viewModel)
            
            Text("Editar tarjeta")
                .typography(.title)
            if let authError = viewModel.error {
                Text(authError.localizedDescription)
                    .typography(.callout)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color("primary"))
                    .cornerRadius(16)
                    .frame(maxWidth: 700)
            }
            LabelledTextBox(label: "Nombre", placeholder: "Ingresa el nombre de la tarjeta", content: $viewModel.card.name)
            HStack(spacing: 32){
                PhotosPicker(selection: $imageSelection) {
                    Label("Seleccionar imagen", systemImage: "pencil")
                }
                .onChange(of: imageSelection) { _ in
                    if let imageSelection {
                        imageSelection.loadTransferable(type: Data.self) { result in
                            switch result {
                            case .success(let data):
                                if let data = data {
                                    print("success")
                                    viewModel.cardImage = UIImage(data: data)
                                } else {
                                    print("unsupported format")
                                }
                            case .failure(_):
                                print("failure retrieving image")
                            }
                        }
                    } else {
                        print("empty")
                    }
                }
                
                NavigationLink {
                    CardMemberEditView(viewModel: viewModel)
                } label: {
                    Label("Colecciones", systemImage: "rectangle.3.group")
                }
            }
            HStack {
                if viewModel.id != nil {
                    Button (role: .destructive) {
                        showDelete = true
                    } label: {
                        Image(systemName: "trash")
                    }
                    .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
                    .confirmationDialog("¿Seguro que quieres borrar esta colección?", isPresented: $showDelete) {
                        Button("Borrar colección", role: .destructive) {
                            viewModel.delete()
                            dismiss()
                        }
                    }
                }
                
                FilledButton(labelText: "Guardar cambios") {
                    viewModel.update()
                    dismiss()
                }
            }
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        .onAppear {
            if viewModel.collections == nil {
                viewModel.loadCurrentCollections()
            }
            if viewModel.cardImage == nil {
                viewModel.loadImage()
            }
        }
    }
}

struct CardEditView_Previews: PreviewProvider {
    @StateObject static var viewModel = CardEditingViewModel(card: Card())
    static var previews: some View {
        CardEditView(viewModel: viewModel)
    }
}
