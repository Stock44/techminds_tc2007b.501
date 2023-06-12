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

struct CardView<ViewModel: ViewableCardViewModel>: ViewModelView {
    @ObservedObject var viewModel: ViewModel
    private let synthesizer = AVSpeechSynthesizer()
    
    init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Button {
            let utterance = AVSpeechUtterance(string: viewModel.card.name)
            utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
            synthesizer.speak(utterance)
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
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(Color("primary lighter"))
                            .frame(maxWidth: .infinity)
                        ProgressView()
                    }
                }
                Text(viewModel.card.name)
                    .typography(.title)
                    .foregroundColor(Color("primary lighter"))
            }
            .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 16))
            .background(Color("primary"))
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
