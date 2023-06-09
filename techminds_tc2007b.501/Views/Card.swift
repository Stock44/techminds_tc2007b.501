//
//  CardStruct.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 26/05/23.
//

import Foundation
import FirebaseFirestoreSwift
import UIKit

struct Card : Codable, Hashable {
    @DocumentID var id : String?
    var name : String = ""
    @ExplicitNull var imageID : UUID?
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageID
    }
}
