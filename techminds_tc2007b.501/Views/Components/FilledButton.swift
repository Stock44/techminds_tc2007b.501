//
//  ButtonView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/05/23.
//

import SwiftUI

struct FilledButton: View {
    var labelText : String
    var action: () -> Void
    
    var body: some View {
        Button (action: action) {
            Text(labelText)
                .font(.custom("Comfortaa", size: 18))
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                .frame(maxWidth: .infinity)
                .background(Color("primary"))
                .foregroundColor(.white)
                .cornerRadius(16)
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FilledButton(labelText: "") {
            
        }
    }
}
