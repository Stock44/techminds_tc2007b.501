//
//  Typography.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 09/05/23.
//

import SwiftUI

enum Typography {
    case largeTitle
    case title
}

extension View {
    func styledNavBarTitle(title: Text) -> some View {
        modifier(StyledNavBarTitle(title: title))
    }
    
    func typography(_ style: Typography) -> some View {
        switch (style) {
        case .largeTitle:
            return self.font(.custom("Comfortaa", size: 48, relativeTo: .largeTitle))
        case .title:
            return self.font(.custom("Comfortaa", size: 32, relativeTo: .title))
        }
    }
}

struct StyledNavBarTitle: ViewModifier {
    var title: Text
    
    init(title: Text) {
        self.title = title
        
        
    }
    
    func body(content: Content) -> some View {
        content.navigationBarTitle(title)
    }
}
