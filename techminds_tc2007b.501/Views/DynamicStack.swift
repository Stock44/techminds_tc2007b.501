//
//  DynamicStack.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 09/05/23.
//

import SwiftUI

struct DynamicStack<Content>: View where Content: View {
    let content: Content
    let spacing: CGFloat
    
    init (spacing: CGFloat = 0, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.spacing = spacing
    }
    
    var body: some View {
        GeometryReader { proxy in
            if proxy.size.width < proxy.size.height {
                VStack(spacing: self.spacing) { content }
            } else {
                HStack(spacing: self.spacing) { content }
            }
        }
    }
}
