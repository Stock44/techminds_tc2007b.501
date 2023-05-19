//
//  AccountInfoView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI
import AVFoundation

struct AccountInfoView: View {
    @State var synthetizer = AVSpeechSynthesizer()
    @State private var nombre = ""
    @State private var apellidos = ""
    @State private var correo = ""
    @State private var contraseña = ""
    
    var body: some View {
        VStack{
           /* Button {
                let utterance = AVSpeechUtterance(string: "Hola")
                let voice = AVSpeechSynthesisVoice(language: "es-MX")
                utterance.voice = voice
                
                synthetizer.speak(utterance)
            } label: {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 200, height: 100)
                        .foregroundColor(Color.black)
                }
            }*/
        }.navigationTitle("Detalles de cuenta")
    }
}

struct AccountInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AccountInfoView()
    }
}
