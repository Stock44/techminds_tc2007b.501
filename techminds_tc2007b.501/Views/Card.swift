//
//  CardStruct.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 26/05/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import UIKit

struct Card : Codable, Hashable, Identifiable {
    @DocumentID var id : String?
    var name : String = ""
    var imageID : UUID = UUID()
    var collections = Set<DocumentReference>()
}
