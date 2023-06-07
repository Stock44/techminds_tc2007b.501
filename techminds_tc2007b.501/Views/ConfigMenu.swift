//
//  ConfigMenu.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 07/06/23.
//

import SwiftUI
import FirebaseAuth

struct ConfigMenu: View {
    enum ConfigMenu {
        case accesibility
        case accountInfo
    }
    @State var selection : ConfigMenu
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Button {
                    selection = .accesibility
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray, style: .init(lineWidth: 5))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                        Text("Accesibilidad")
                            .font(.custom("Comfortaa", size: 18))
                            .foregroundColor(.black)
                    }
                }

                Button {
                    selection = .accountInfo
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray, style: .init(lineWidth: 5))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                        Text("Detalles de la cuenta")
                            .font(.custom("Comfortaa", size: 18))
                            .foregroundColor(.black)
                    }
                }
            }
            .frame(maxWidth: 250, maxHeight: .infinity)
            
            switch selection {
            case .accesibility:
                AccessibilityConfigView()
            case .accountInfo:
                AccountInfoView()
            }
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        .navigationTitle("Configuración")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    do {
                     try Auth.auth().signOut()
                    } catch {
                     print("could not sign out")
                    }
                } label: {
                    Image(systemName:  "rectangle.portrait.and.arrow.right")
                    
                }
            }
        }
    }
}

struct ConfigMenu_Previews: PreviewProvider {
    static var previews: some View {
        ConfigMenu(selection: .accesibility)
    }
}
