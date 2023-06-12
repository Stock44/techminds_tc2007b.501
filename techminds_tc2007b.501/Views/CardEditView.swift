//
//  CardEditView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/06/23.
//

import SwiftUI
import PhotosUI

struct CardEditView: ViewModelView {
    typealias ViewModel = CardEditingViewModel
    
    @State private var showDelete: Bool = false
    @State var imageSelection: PhotosPickerItem?
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32){
            CardView(viewModel: viewModel)
            
                Text("Editar tarjeta")
                    .typography(.title)
                
            LabelledTextBox(label: "Nombre", placeholder: "Ingresa el nombre de la tarjeta", content: $viewModel.card.name)
            
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
            if viewModel.cardImage == nil {
                viewModel.loadCurrentImage()
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
