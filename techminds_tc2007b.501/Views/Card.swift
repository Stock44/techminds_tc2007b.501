//
//  CardStruct.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 26/05/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Card : Codable, Hashable {
    @DocumentID var id : String?
    var name : String
    var imageURL : URL?
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
}
