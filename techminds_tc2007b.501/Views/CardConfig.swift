//
//  CardConfig.swift
//  techminds_tc2007b.501
//
//

import SwiftUI
import PhotosUI

struct CardConfig: View {
    @State private var bgColor = Color.blue
    
    @State var name : String = ""
    @State var contraseña : String = ""
    @State var busqueda : String = ""
    @State var toggle = true
    @State var confirmar = true
    
    @State private var selectedItem : PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32){
            HStack{
                Text("      Todas Las Tarjetas   ")
                    .font(.custom("Raleway", size: 60))
                
                Button {
                    
                } label: {
                    Image("system-group")
                        .foregroundColor(                Color("primary"))
                        .padding(EdgeInsets(top: 0, leading: 400, bottom: 0, trailing: 0))
                }
                
                
                Button  {
                }label: {
                    
                    Image(systemName: "plus")
                        .foregroundColor(                Color("primary"))
                        .symbolVariant(.circle)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .font(.system(size: 30))
                }
                
                Button {
                }label: {
                    Image(systemName: "trash")
                        .foregroundColor(                Color("primary"))
                        .symbolVariant(.circle)
                        .font(.system(size: 30))
                }
                
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 32) {
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 36))
                            .foregroundColor(Color("primary"))
                        LabelledTextBox(label: "", placeholder: "Buscar", content: $name)
                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 16, trailing: 10))
                    }
                    HStack{
                        Text("Configuraciones")
                            .font(.custom("Raleway", size: 26))
                    }
                    HStack{
                        Text("Setting 1")
                            .font(.custom("Raleway", size: 16))
                        Toggle("", isOn: $toggle)
                    }
                    HStack{
                        Text("Setting 2")
                            .font(.custom("Raleway", size: 16))
                        Toggle("", isOn: $toggle)
                    }
                    HStack{
                        Text("Setting 3")
                            .font(.custom("Raleway", size: 16))
                        Toggle("", isOn: $toggle)
                    }
                    HStack{
                        Text("Setting 4")
                            .font(.custom("Raleway", size: 16))
                        Toggle("", isOn: $toggle)
                    }
                    HStack{
                        Text("Setting 5")
                            .font(.custom("Raleway", size: 16))
                        Toggle("", isOn: $toggle)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 64, bottom: 0, trailing: 64))
                .frame(maxWidth: .infinity)
                
                //IMAGEN - IMAGE PICKER (funciona) modificar tamaño 
                VStack(alignment: .leading, spacing: 8){
                    ZStack{
                        PhotosPicker(selection: $selectedItem,matching: .any (of:
                        [.images, .not(.livePhotos)])) {
                            Image("Imagen")
                        }
                            .padding(EdgeInsets(top: 0, leading: 64, bottom: 0, trailing: 64))
                        
                            .onChange(of: selectedItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedPhotoData = data
                                }
                            }
                        }
                        
                        if let selectedPhotoData,
                           let image = UIImage(data: selectedPhotoData) {
                            
                            Image(uiImage: image)
                                .resizable()
                                .padding(EdgeInsets(top: 0, leading: 64, bottom: 0, trailing: 64))
                                .frame(maxWidth: 670, maxHeight: 360)
                        }
                        
                 
                        
                    }
                    
                    LabelledTextBox(label: "Nombre", placeholder: "Nombre de Imagen", content: $name)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                    
                    FilledButton(labelText: "Confirmar") {
                        confirmar = false
                    }
                }
                .frame(maxWidth: .infinity)
            }.navigationTitle("Todas las tarjetas")
        }
        
    }
}




struct CardConfig_Previews: PreviewProvider {
    static var previews: some View {
        CardConfig()
    }
}

