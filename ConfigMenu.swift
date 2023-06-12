//
//  ConfigMenu.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 09/06/23.
//

import SwiftUI
import FirebaseAuth

struct ConfigMenu: View {
    enum ConfigMenu {
        case accesibility
        case accountInfo
    }
    @State private var selection = ConfigMenu.accesibility

    var body: some View {
        HStack(alignment: .top) {
            List{
                Section(header: Text("Configuración")){
                    Button {
                        selection = .accesibility
                    } label: {
                    Text("Accesibilidad")
                            .font(.custom("Comfortaa", size: 18))
                            .foregroundColor(.black)
                    }

                    Button {
                        selection = .accountInfo
                    } label: {
                        Text("Detalles de la cuenta")
                            .font(.custom("Comfortaa", size: 18))
                            .foregroundColor(.black)
                    }
                }
        }
            .listStyle(.inset)
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
                    Label("Cerrar sesión", systemImage:  "rectangle.portrait.and.arrow.right")

                }
            }
        }
    }
}

struct ConfigMenu_Previews: PreviewProvider {
    static var previews: some View {
        ConfigMenu()
    }
}
