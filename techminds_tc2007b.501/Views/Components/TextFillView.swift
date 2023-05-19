//
//  TextFillView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI

struct TextFillView: View {
    var textTitle : String
    var variable : Binding<String>
    var temporalText : String
    var textFillWidth : CGFloat
    var textFillHeight : CGFloat
    
    var body: some View {
        Text(textTitle)
            .font(.custom("Comfortaa", size: 16))
        
        TextField(text: variable) {
                Text(temporalText)
                .font(.custom("Raleway", size: 18))
            }
        .frame(width: textFillWidth, height: textFillHeight)
        .offset(x: 20)
        .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
    }
}

struct TextFillView_Previews: PreviewProvider {
    static var previews: some View {
        TextFillView(textTitle: "", variable: .constant(""), temporalText: "", textFillWidth: 437, textFillHeight: 57)
    }
}
