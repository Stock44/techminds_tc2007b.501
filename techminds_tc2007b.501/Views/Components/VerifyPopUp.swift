//
//  VerifyPopUp.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 31/05/23.
//

import SwiftUI

struct VerifyPopUp: View {
    @ObservedObject var viewModel: UserEditingViewModel
    @State var password : String = ""
    @State var errorAlert = false
    @State var popup = false
    @Environment(\.dismiss) var dismiss
    @Binding var exito : Bool
    @Binding var errorUpdate : Error?
    
    var body: some View {
        VStack(spacing: 32){
            Text("Ingresa tu contraseña para realizar cambios a esta cuenta")
                .font(.custom("Comfortaa",size: 24))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            SecureField("Contraseña", text: $password)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                .border(Color.black, width: 0.1)
                .background(Color("accent1 lighter"))
                .padding(.horizontal, 70.0)
            
                FilledButton(labelText: "Aceptar"){
                    if viewModel.password != "" {
                        print("updating password")
                        Task {
                            do {
                                try await viewModel.updatePassword(password: password)
                            } catch {
                                errorUpdate = error
                            }
                            
                        }
                    }
                    
                    if viewModel.email != "" {
                        print("updating email")
                        Task {
                            do {
                                try await viewModel.updateEmail(password: password)
                            } catch {
                                // error...
                                errorUpdate = error
                            }
                        }
                    }
                    
                    dismiss()
                }
                .background(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 1))
            .frame(maxWidth: 200)
        }
        .padding(.all, 16.0)
        .frame(maxWidth: .infinity, maxHeight: 432)
        .background(Color("primary"))
    }
}

struct VerifyPopUp_Previews: PreviewProvider {
    @State static var viewModel = UserEditingViewModel()
    static var previews: some View {
        VerifyPopUp(viewModel: viewModel, exito: .constant(false), errorUpdate: .constant(nil))
    }
}
