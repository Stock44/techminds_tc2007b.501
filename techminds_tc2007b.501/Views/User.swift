//
//  UserStruct.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 26/05/23.
//

import Foundation

struct User : Hashable {
    var useButtons : Bool
    var usePoseEstimation : Bool
    var useVoiceOver : Bool
    var fontSize : Float
    var buttonSize : Float
    var cardSize : Float //puede ser un escalable
    var rows : Int
    var columns : Int
}
