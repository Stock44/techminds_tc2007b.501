//
//  ImagePicker.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 07/06/23.
//
import SwiftUI
import PhotosUI

struct ImagePicker: View {
    @State private var selectedItem : PhotosPickerItem?
    @State private var selectedPhotoData: Data?

    
    var body: some View {
        
        if let selectedPhotoData,
            let image = UIImage(data: selectedPhotoData) {
         
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .clipped()
         
        }
        PhotosPicker(selection: $selectedItem,matching: .any(of:
        [.images, .not(.livePhotos)])) {
            Label("Selecciona una foto", systemImage: "photo")
        }
        .tint(.purple)
        .controlSize(.large)
        .buttonStyle(.borderedProminent)
        .onChange(of: selectedItem) { newItem in
        Task {
            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                selectedPhotoData = data
                
            }
        }
    }
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker()
    }
}
