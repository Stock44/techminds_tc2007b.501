//
//  Collection.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 31/05/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Collection : Codable {
    @DocumentID var id: String?
    var name: String
    var color: CodableColor
    var cards: [DocumentReference] = []
}