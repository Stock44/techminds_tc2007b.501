//
//  MainMenuView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/05/23.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        DynamicStack (spacing: 24) {
            VStack{
                Image("carousel-horizontal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: .infinity)
                Text("Tarjetas")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .typography(.largeTitle)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.all, 24)
            .foregroundColor(Color("accent2 darker"))
            .background(Color("accent2 lighter"))
                .cornerRadius(16)
            VStack {
                Image("system-group")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: .infinity)
                Text("Colecciones")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .typography(.largeTitle)
            }
            .frame(maxWidth: .infinity, maxHeight:.infinity)
            .padding(.all, 24)
            .foregroundColor(Color("secondary darker"))
            .background(Color("secondary lighter"))
                .cornerRadius(16)
        }
        .navigationBarTitle(Text("Menú principal"))
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Image("settings")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
        }
        .padding(EdgeInsets(top: 32, leading: 48, bottom: 32, trailing: 48))
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
