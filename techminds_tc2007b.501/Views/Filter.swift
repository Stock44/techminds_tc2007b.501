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
            
            NavigationLink("", destination: target(), isActive: $cleared)

        }
        .onAppear{
            num1 = number1()
            num2 = number2()
        }
        .navigationTitle("Completa la operacion para continuar")
    }
}

struct Verificacion_Previews: PreviewProvider {
    static var previews: some View {
        Filter {
            Text("hello")
        }
    }
}
