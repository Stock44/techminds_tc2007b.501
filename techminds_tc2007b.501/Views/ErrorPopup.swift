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
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color("primary"))
            .cornerRadius(16)
    }
}

struct ErrorPopup_Previews: PreviewProvider {
    static var previews: some View {
        ErrorPopup(label: "Error")
    }
}
