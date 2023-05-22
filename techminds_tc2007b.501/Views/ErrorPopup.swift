//
//  ErrorPopup.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 22/05/23.
//

import SwiftUI

struct ErrorPopup: View {
    var label: String
    var body: some View {
        Text(label)
            .typography(.callout)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .background(.black)
            .cornerRadius(8)
    }
}

struct ErrorPopup_Previews: PreviewProvider {
    static var previews: some View {
        ErrorPopup(label: "Error")
    }
}
