//
//  StudentCards.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI
import AVFoundation

struct StudentCards: View {
    var cardColor : String
    var cardImage : String
    var imageTitle : String
    
    var body: some View {
        Button {
            let synthetizer =  AVSpeechSynthesizer()
            synthetizer.stopSpeaking(at: .immediate)
                
            let utterance = AVSpeechUtterance(string: imageTitle)
            utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
            
            synthetizer.speak(utterance)
        } label: {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 16)
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .foregroundColor(Color(cardColor))
                Image(cardImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: .infinity, height: .infinity)
            }
        }
    }
}

struct StudentCards_Previews: PreviewProvider {
    static var previews: some View {
        StudentCards(cardColor: "primary lighter", cardImage: "perro", imageTitle: "perro")
    }
}
