//
//  InitialView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 22/05/23..
//

import SwiftUI

struct InitialView: View {
    
    @State private var isRotating = 0.0

    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                Color("primary lighter")
                    .edgesIgnoringSafeArea(.all)
                // Logo o imagen de la app
                Image("logo")
                    .resizable()
                    .frame(width: geo.size.width/4, height: geo.size.width/4)

            }
        }

    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
