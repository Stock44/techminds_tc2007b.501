//
//  Filter.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 09/06/23.
//

import SwiftUI

struct Filter<TargetView: View>: View {
    
    let target: () -> TargetView

    @State private var resultado : String = ""
    @State private var num1 = 0
    @State private var num2 = 0
    @State private var cleared = false
    @State private var error = false
    
    init(@ViewBuilder target: @escaping () -> TargetView) {
        self.target = target
    }
    
    func number1() -> Int {
        return Int.random(in: 3...12)
    }
    
    func number2() -> Int {
        return Int.random(in: 3...12)
    }
    
    func answer(num1: Int, num2: Int) -> Int {
           return num1 * num2
    }
    
    var body: some View {
        VStack {
            HStack{
                Text("\(num1) × \(num2) = ")
                    .font(.custom("Comfortaa", size: 46))
                TextField("Resultado", text: $resultado)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)
                    .keyboardType(.phonePad)
            }
            

            Button {
                cleared = resultado == String(answer(num1: num1, num2: num2))
                error = !cleared
            }label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 300, height: 50)
                        .foregroundColor(Color("primary"))
                    Text("Confirmar")
                        .font(.custom("Comfortaa", size: 18))
                        .foregroundColor(.white)
                }
            }
            
            ZStack {
                Rectangle()
                .fill(.background)
                .frame(maxWidth: .infinity, maxHeight: 300)
                if error == true {
                    Text("Resultado incorrecto")
                        .typography(.callout)
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                        .frame(maxWidth: 300)
                        .foregroundColor(.white)
                        .background(Color("primary"))
                        .cornerRadius(16)
                }
            }
            .onTapGesture {
                error = false
            }
            NavigationLink("", destination: target(), isActive: $cleared)

        }
        .padding()
        .onAppear{
            num1 = number1()
            num2 = number2()
        }
        .navigationTitle("Completa la operacion para continuar")
    }
}

struct Filter_Previews: PreviewProvider {
    static var previews: some View {
        Filter {
            Text("hello")
        }
    }
}
