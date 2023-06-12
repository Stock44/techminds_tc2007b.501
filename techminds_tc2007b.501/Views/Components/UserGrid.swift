//
//  UserGrid.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/06/23.
//

import SwiftUI

protocol ViewModelView: View {
    associatedtype ViewModel: ObservableObject
    
    init(viewModel: ViewModel)
}

struct UserGrid<T: Identifiable, V: ViewModelView>: View where V.ViewModel == T{
    var viewModels: [T]
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        let columns = userViewModel.userProperties?.columns ?? 3
        let rows = userViewModel.userProperties?.rows ?? 3
        TabView {
            ForEach(Array(stride(from: 0, to: viewModels.count, by: columns * rows)), id: \.self) { offset in
                Grid (horizontalSpacing: 16, verticalSpacing: 16){
                    ForEach(0..<rows, id: \.self) { row in
                        let start = min(offset + row * columns, viewModels.count)
                        let end = min(offset + (row + 1) * columns, viewModels.count)
                        let missing = columns - (end - start)
                        GridRow {
                            ForEach(viewModels[start..<end]) { viewModel in
                                V(viewModel:  viewModel)
                            }
                            ForEach(0..<missing, id: \.self) { _ in
                                Color.clear
                            }
                        }
                        
                    }
                }
                .padding(EdgeInsets(top: 32, leading: 48, bottom: 32, trailing: 48))
            }
        }
        .onAppear {
            userViewModel.getCurrent()
        }
        .tabViewStyle(.page)
    }
}

