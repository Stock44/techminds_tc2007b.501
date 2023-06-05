//
//  CardStruct.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 26/05/23.
//

import Foundation

struct Card : Codable, Hashable {
    var id : String!
    var name : String
    var imageURL : String
}
