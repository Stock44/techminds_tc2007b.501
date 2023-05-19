//
//  StudentCards.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI
import AVFoundation

struct StudentCards: View {
    var cardWidth : CGFloat
    var cardHeight : CGFloat
    var cardColor : String
    var cardImage : String
    var imageWidth : CGFloat
    var imageHeight : CGFloat
    var imageTitle : String
    
    var body: some View {
        Button {
            let utterance = AVSpeechUtterance(string: imageTitle)
            utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
            
            let synthetizer =  AVSpeechSynthesizer()
            synthetizer.speak(utterance)
        } label: {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: cardWidth, height: cardHeight)
                    .foregroundColor(Color(cardColor))
                Image(cardImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageWidth, height: imageHeight)
            }
        }
    }
}

struct StudentCards_Previews: PreviewProvider {
    static var previews: some View {
        StudentCards(cardWidth: 350, cardHeight: 350, cardColor: "primary lighter", cardImage: "perro", imageWidth: 336, imageHeight: 336, imageTitle: "perro")
    }
}
