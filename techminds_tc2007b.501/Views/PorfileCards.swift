
import SwiftUI
struct ProfileCards: View {
    @State private var name: String = ""
    @State private var cardCount = 1

    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    cardCount += 1
                }) {
                    Text("Agregar Usuario")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.trailing, 16)
            }
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(0..<cardCount, id: \.self) { index in
                        ProfileCardView(name: "Erick Hernandez")
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            }
        }
    }
}


struct ProfileCardView: View {
    let name: String
    
    var body: some View {
        ZStack {
            //CARD
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(Color.gray, lineWidth: 1)
                .frame(width: cardWidth, height: cardHeight)
                .background(Color.white)
          
            VStack(alignment: .leading, spacing: 10) {
                LazyVStack(alignment: .leading, spacing: 2) {
                    Circle()
                        .fill(Color("primary lighter"))
                        .frame(width: 100, height: 100)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                        .overlay(
                            
                            Text(String(name.prefix(1)))
                                .font(.system(size: 48))
                                .foregroundColor(.orange)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                        )
                    
                    Spacer()
                    
                    Text(name)
                        .font(.custom("Raleway-Regular", size: 14))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 11)
            }
            .frame(width: cardWidth, height: cardHeight)
            .cornerRadius(cornerRadius)
        }
       
    }
    private let cardWidth: CGFloat = 170
    private let cardHeight: CGFloat = 250
    private let cornerRadius: CGFloat = 18
 
}


struct ProfileCards_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCards()
    }
}




