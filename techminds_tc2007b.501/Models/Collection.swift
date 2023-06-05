//
//  Collection.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 31/05/23.
//

import SwiftUI

struct Collection : Codable {
    var name: String
    var color: CodableColor
    var cards: [Card]
}
