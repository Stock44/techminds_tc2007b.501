//
//  UserGrid.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/06/23.
//

import SwiftUI

struct UserDataGrid<T: Identifiable, V: View> : View{
    var data: [T]
    var content: (T) -> V
    var emptyLabel: String
    
    @StateObject var userViewModel = UserViewModel()
    
    init(_ data: [T], emptyLabel: String, @ViewBuilder content: @escaping (T) -> V) {
        self.data = data
        self.emptyLabel = emptyLabel
        self.content = content
    }
    
    var body: some View {
        if data.count == 0 {
            Text(emptyLabel)
                .typography(.headline)
        } else {
            let columns = userViewModel.userProperties?.columns ?? 3
            let rows = userViewModel.userProperties?.rows ?? 3
            TabView {
                ForEach(Array(stride(from: 0, to: data.count, by: columns * rows)), id: \.self) { offset in
                    Grid (horizontalSpacing: 16, verticalSpacing: 16){
                        ForEach(0..<rows, id: \.self) { row in
                            let start = min(offset + row * columns, data.count)
                            let end = min(offset + (row + 1) * columns, data.count)
                            let missing = columns - (end - start)
                            
                            GridRow {
                                ForEach(data[start..<end]) { data in
                                    content(data)
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
            .tabViewStyle(.page)
            .onAppear {
                userViewModel.getCurrent()
            }
        }
    }
}

