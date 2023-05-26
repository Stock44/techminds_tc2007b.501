//
//  CardModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 26/05/23.
//

import Foundation
import FirebaseFirestore

class CardModel : ObservableObject {
    @Published var cardsList = [CardStruct]()
    
    let db = Firestore.firestore()
    
    init() {
        Task {
            if let users = await getData() {
                DispatchQueue.main.async {
                    self.cardsList = users
                }
            }
        }
    }
    
    func addData(aCard : CardStruct, completion : @escaping (String) -> Void) {
        db.collection("card").addDocument(data: ["name": aCard.name, "image": aCard.image, "collections": aCard.collections, "owner": aCard.owner]) { err in
            if let err = err {
                completion(err.localizedDescription)
            }
            else {
                completion("Ok")
            }
        }
    }
    
    func getData() async -> [CardStruct]? {
        do {
            let querySnapshot = try await db.collection("card").getDocuments()
            
            var cardArr = [CardStruct]()
            
            for document in querySnapshot.documents {
                let data = document.data()
                let name = data["name"] as? String ?? "sin nombre"
                let image = data["image"] as? String ?? "sin imagen"
                let collections = data["collections"] as? [CollectionStruct] ?? []
                let owner = data["owner"] as? UserStruct ?? UserStruct(email: "", firstName: "", lastName: "", useButtons: false, usePoseEstimation: false, useVoiceOver: false, fontSize: 18, buttonSize: 350, cardSize: 350, rows: 3, columns: 3)
                let id = document.documentID
                
                let unEquipo = CardStruct(id: id,name: name, image: image, collections: collections, owner: owner)
            }
            return cardArr
        }
        catch {
            print("ERROR")
        }
        return nil
    }
    
    func updateData(aCard : CardStruct) async -> String {
        do {
            try await db.collection("card").document(aCard.id).setData(["name": aCard.name, "image": aCard.image, "collections" : aCard.collections, "owner": aCard.owner])
        }
        catch {
            return "Error al modificar la colección"
        }
        return "Ok"
    }
    
    func removeData(aCard : CollectionStruct) async -> String {
        if let docID  = aCard.id {
            do {
                try await db.collection("card").document(docID).delete()
            }
            catch {
                return "Error al borrar un equipo"
            }
        }
        return "Ok"
    }

}
