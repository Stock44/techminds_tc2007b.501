//
//  ContentView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 05/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            LogIn(correo: "", contraseña: "", login: true)

        }.navigationViewStyle(.stack)
            .font(Font.custom("Comfortaa-Medium", size: 18)).onAppear {
        for family: String in UIFont.familyNames
        {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
