//
//  LabelledPasswordBox.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 01/06/23.
//

import SwiftUI

struct LabelledPasswordBox: View {
    var label : String
    var placeholder : String
    var content : Binding<String>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .typography(.subheadline)
            
            SecureField(text: content){
                Text(placeholder)
                    .typography(.body)
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 1))
            
        }
        .frame(maxWidth: .infinity)
    }
}

struct LabelledPasswordBox_Previews: PreviewProvider {
    static var previews: some View {
        LabelledPasswordBox(label: "", placeholder: "", content: .constant(""))
    }
}
