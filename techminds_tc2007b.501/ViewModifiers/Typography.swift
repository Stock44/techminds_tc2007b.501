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
    case headline
    case subheadline
    case body
    case callout
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
        case .headline:
            return self.font(.custom("Comfortaa", size: 24, relativeTo: .headline))
        case .subheadline:
            return self.font(.custom("Comfortaa", size: 16, relativeTo: .subheadline))
        case .body:
            return self.font(.custom("Raleway", size: 14, relativeTo: .body))
        case .callout:
            return self.font(.custom("Raleway", size: 14, relativeTo: .callout))
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
