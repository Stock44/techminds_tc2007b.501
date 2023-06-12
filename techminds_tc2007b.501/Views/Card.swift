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
    
    init(id: String? = nil, name: String = "", imageID: UUID = UUID(), collections: Set<DocumentReference> = Set<DocumentReference>()) {
        self.id = id
        self.name = name
        self.imageID = imageID
        self.collections = collections
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(DocumentID<String>.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageID = try container.decode(UUID.self, forKey: .imageID)
        self.collections = Set(try container.decode([DocumentReference].self, forKey: .collections))
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageID
        case collections
    }
}
