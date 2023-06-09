//
//  Filter.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 09/06/23.
//

import SwiftUI

struct Filter: View {
    
    @State private var resultado : String = ""
    @State private var num1 = 0
    @State private var num2 = 0
    
    func number1() -> Int {
        return Int.random(in: 2...50)
    }
    
    func number2() -> Int {
        return Int.random(in: 2...5)
    }
    
    func answer(num1: Int, num2: Int) -> Int {
           return num1 * num2
    }
    
    var body: some View {
        VStack {
            HStack{
                Text("\(num1) * \(num2)")
                    .font(.custom("Comfortaa", size: 46))
                TextField("Resultado", text: $resultado)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)
                    .keyboardType(.phonePad)
            }
            
            NavigationLink {
                if resultado == String(answer(num1: num1, num2: num2)) {
                    ConfigMenu(selection: .accesibility)
                } else {
                    MainMenuView()
                }
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
        Filter()
    }
}
