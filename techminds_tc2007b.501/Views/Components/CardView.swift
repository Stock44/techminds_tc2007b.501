//
//  CardView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/06/23.
//

import SwiftUI
import AVFoundation

protocol ViewableCardViewModel: ObservableObject {
    var card: Card {get}
    var cardImage: UIImage? {get}
}

struct CardView<ViewModel: ViewableCardViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    var customColor: Color?
    private let synthesizer = AVSpeechSynthesizer()
    private var utterance = AVSpeechUtterance(string: "")
    
    init(viewModel: ViewModel, customColor: Color? = nil) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        
        self.customColor = customColor
        
        utterance = AVSpeechUtterance(string: viewModel.card.name)
        utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
        utterance.rate = 0.55
    }
    
    var body: some View {
        Button {
            if !synthesizer.isSpeaking {
                synthesizer.speak(utterance)
            }
        } label: {
            DynamicStack(spacing: 16) {
                if let image = viewModel.cardImage {
                    Color.clear
                        .overlay {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                            
                        }
                        .cornerRadius(16)
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                Text(viewModel.card.name)
                    .typography(.headline)
                    .foregroundColor(customColor ?? Color("primary"))
                    .colorInvert()
                    .contrast(3.5)
            }
            .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 16))
            .background(customColor ?? Color("primary"))
            .cornerRadius(16)
        }
        .buttonStyle(.plain)
    }
}

struct CardView_Previews: PreviewProvider {
    @StateObject static var viewModel = CardViewModel(card: Card(name: "Example card"))
    static var previews: some View {
        CardView(viewModel: viewModel)
    }
}
