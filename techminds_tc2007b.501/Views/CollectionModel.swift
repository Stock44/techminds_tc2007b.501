//
//  CollectionModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 26/05/23.
//

import Foundation
import FirebaseFirestore

class CollectionModel : ObservableObject {
    @Published var collectionsList = [CollectionStruct]()
    
    let db = Firestore.firestore()
    
    init() {
        Task {
            if let users = await getData() {
                DispatchQueue.main.async {
                    self.collectionsList = users
                }
            }
        }
    }
    
    func addData(aCollection : CollectionStruct, completion : @escaping (String) -> Void) {
        db.collection("collection").addDocument(data: ["name": aCollection.name, "color": aCollection.color, "cards": aCollection.cards, "owner": aCollection.owner]) { err in
            if let err = err {
                completion(err.localizedDescription)
            }
            else {
                completion("Ok")
            }
        }
    }
    
    func getData() async -> [CollectionStruct]? {
        do {
            let querySnapshot = try await db.collection("collection").getDocuments()
            
            var collectionArr = [CollectionStruct]()
            
            for document in querySnapshot.documents {
                let data = document.data()
                let name = data["name"] as? String ?? "sin nombre"
                let color = data["color"] as? String ?? "sin color"
                let cards = data["cards"] as? [CardStruct] ?? []
                let owner = data["owner"] as? UserStruct ?? UserStruct(email: "", firstName: "", lastName: "", useButtons: false, usePoseEstimation: false, useVoiceOver: false, fontSize: 18, buttonSize: 350, cardSize: 350, rows: 3, columns: 3)
                let id = document.documentID
                
                let unEquipo = CollectionStruct(name: id, color: color, cards: cards, owner: owner)
            }
            return collectionArr
        }
        catch {
            print("ERROR")
        }
        return nil
    }
    
    func updateData(aCollection : CollectionStruct) async -> String {
        do {
            try await db.collection("collection").document(aCollection.id).setData(["name": aCollection.name, "color": aCollection.color, "cards" : aCollection.cards, "owner": aCollection.owner])
        }
        catch {
            return "Error al modificar la colección"
        }
        return "Ok"
    }
    
    func removeData(aCollection : CollectionStruct) async -> String {
        if let docID  = aCollection.id {
            do {
                try await db.collection("collection").document(docID).delete()
            }
            catch {
                return "Error al borrar un equipo"
            }
        }
        return "Ok"
    }

}
