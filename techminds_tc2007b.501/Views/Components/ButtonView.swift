//
//  ButtonView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/05/23.
//

import SwiftUI

struct ButtonView: View {
    var action: String
    var buttonColor : String
    var buttonText : String
    var buttonWidth : CGFloat
    var buttonHeight : CGFloat
    
    var body: some View {
        Button {
            action
        } label: {
            ZStack {
                Rectangle()
                    .fill(Color(buttonColor))
                    .frame(width: buttonWidth, height: buttonHeight)
                    .cornerRadius(16)
                
                Text(buttonText)
                    .font(.custom("Conmfortaa", size: 18))
                    .foregroundColor(.white)
            }
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(action: "", buttonColor: "", buttonText: "", buttonWidth: 0, buttonHeight: 0)
    }
}
