//
//  MainMenuView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/05/23.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        HStack {
            VStack{
                Image("menucard")
                Text("Tarjetas")
            }.background(Color("accent2 lighter"))
                .cornerRadius(16)
                
            VStack {
                Text("Colecciones")
            }.background(Color("secondary lighter"))
                .cornerRadius(16)
        }.navigationTitle("Menú principal")
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
