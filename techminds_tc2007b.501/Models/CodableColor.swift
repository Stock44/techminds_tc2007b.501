//
//  CodableColor.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 05/06/23.
//

import Foundation
import SwiftUI

struct CodableColor : Codable, Hashable {
    var cgColor: CGColor
    var color: Color {
        Color(cgColor: cgColor)
    }
    
    enum CodingKeys: String, CodingKey {
        case colorSpace
        case components
    }
    
    init (cgColor: CGColor) {
        self.cgColor = cgColor
    }
    
    init(from decoder: Decoder ) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let colorSpace = try container.decode(String.self, forKey: .colorSpace)
        let components = try container.decode([CGFloat].self, forKey: .components)
        
        guard
            let cgColorSpace = CGColorSpace(name: colorSpace as CFString),
            let cgColor = CGColor(colorSpace: cgColorSpace, components: components)
        else {
            throw CodingError.wrongData
        }
        self.cgColor = cgColor
    }
    
    func encode(to encoder: Encoder ) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        guard
            let colorSpace = cgColor.colorSpace?.name,
            let components = cgColor.components
        else {
            throw CodingError.wrongData
        }
        
        try container.encode(colorSpace as String, forKey: .colorSpace)
        try container.encode(components, forKey: .components)
    }
}

enum CodingError: Error {
    case wrongData
    case wrongColor
}
