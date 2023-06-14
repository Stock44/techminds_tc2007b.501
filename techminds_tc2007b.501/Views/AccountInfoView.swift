//
//  AccountInfoView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI

struct AccountInfoView: View {
    @State private var passwordConfirmation = ""
    
    @State var popup = false
    @State var buttontext = "Editar"
    @State private var nonMatchingPasswords = false
    @State var exito = false
    @State var errorUpdate : Error?
    
    @StateObject private var viewModel = UserEditingViewModel()
    
    
    var body: some View {
        ZStack {
            VStack (spacing: 32){
                Group{
                    if let authError = errorUpdate {
                        Text(authError.localizedDescription)
                            .typography(.callout)
                            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("primary"))
                            .cornerRadius(16)
                            .frame(maxWidth: 700)
                    }else if nonMatchingPasswords == true{
                        Text("Las contraseñas no coinciden")
                            .typography(.callout)
                            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("primary"))
                            .cornerRadius(16)
                            .frame(maxWidth: 700)
                    }
                    LabelledTextBox(label: "Nombre", placeholder: "Campo requerido",content: $viewModel.userProperties.name)
                        .frame(maxWidth: 700)

                    LabelledTextBox(label: "Apellidos", placeholder: "Campo requerido",content: $viewModel.userProperties.surname)
                        .frame(maxWidth: 700)

                    LabelledTextBox(label: "Correo", placeholder: "Nuevo correo electronico",content: $viewModel.email)
                        .frame(maxWidth: 700)

                    LabelledPasswordBox(label: "Contraseña", placeholder: "Nueva contraseña",content: $viewModel.password)
                        .frame(maxWidth: 700)

                    LabelledPasswordBox(label: "Confirmar contraseña", placeholder: "Ingresa la misma contraseña", content: $passwordConfirmation)
                        .frame(maxWidth: 700)
                }
                FilledButton(labelText: buttontext) {
                    if viewModel.password != "" || viewModel.email != ""{
                        if viewModel.password == passwordConfirmation {
                            popup = true
                            nonMatchingPasswords = false
                        } else {
                            nonMatchingPasswords = true
                        }
                    }
                    
                    Task {
                        do {
                            try await viewModel.update()
                            exito = true
                        } catch {
                            errorUpdate = error
                        }
                    }
                    
                }
                .frame(maxWidth: 700)
                .popover(isPresented: $exito) {
                    ZStack {
                        Color("primary lighter")
                            .scaleEffect(1.5)
                        Text("Cambios guardados con éxito")
                            .typography(.callout)
                            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color("primary"))
                    }
                }
                .popover(isPresented: $popup) {
                    VerifyPopUp(viewModel: viewModel, exito: $exito, errorUpdate: $errorUpdate)
                }
                .padding(.bottom, 100)
            }
            .padding(.leading, 40)
            .navigationTitle("Información de la cuenta")
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            viewModel.loadCurrent()
        }
    }
}

struct AccountInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AccountInfoView()
    }
}
