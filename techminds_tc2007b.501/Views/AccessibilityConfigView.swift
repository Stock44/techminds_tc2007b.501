//
//  AccessibilityConfigView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI

struct AccessibilityConfigView: View {
    
    @StateObject private var viewModel = UserEditingViewModel()
    
    var body: some View {
        DynamicStack{
            Grid (horizontalSpacing: 16, verticalSpacing: 16){
                ForEach(0..<viewModel.userProperties.rows, id: \.self) { row in
                    GridRow {
                        ForEach(0..<viewModel.userProperties.columns, id: \.self) { _ in
                            Color("primary")
                                .cornerRadius(16)
                        }
                    }
                    
                }
            }
            .padding(EdgeInsets(top: 32, leading: 48, bottom: 32, trailing: 48))
            VStack{
                List {
                    Section("Interfaz") {
                        HStack {
                            Text("Filas: \(viewModel.userProperties.rows)")
                                .typography(.callout)
                                .frame(maxWidth: 96, alignment: .leading)
                            Slider(value: .convert(from: $viewModel.userProperties.rows),in: 1...5, step: 1)
                        }
                        HStack {
                            Text("Columnas: \(viewModel.userProperties.columns)")
                                .typography(.callout)
                                .frame(maxWidth: 96, alignment: .leading)
                            Slider(value: .convert(from: $viewModel.userProperties.columns), in: 1...5, step: 1)
                        }
                        
                        
                    }
                }.listStyle(.plain)
                
                FilledButton(labelText: "Guardar") {
                    viewModel.update()
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.loadCurrent()
        }
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        .frame(maxWidth: .infinity)
        .navigationTitle("Accesibilidad")
    }
}



struct AccessibilityConfigView_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityConfigView()
    }
}
