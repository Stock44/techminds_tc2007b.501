//
//  Collection.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 31/05/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Collection : Codable, Hashable, Identifiable {
    static func == (lhs: Collection, rhs: Collection) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @DocumentID var id: String?
    var name: String = ""
    var color = CodableColor(cgColor: CGColor(gray: 0.7, alpha: 1.0))
    var enabled: Bool = true
    var cards = Set<DocumentReference>()
}
