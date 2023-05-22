//
//  TextFillView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI

struct LabelledTextBox: View {
    var label : String
    var placeholder : String
    var content : Binding<String>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.custom("Comfortaa", size: 16))
            
            TextField(text: content) {
                Text(placeholder)
                    .font(.custom("Raleway", size: 18))
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 1))
        }
        .frame(maxWidth: .infinity)
    }
}

struct TextFillView_Previews: PreviewProvider {
    static var previews: some View {
        LabelledTextBox(label: "", placeholder: "", content: .constant(""))
    }
}
