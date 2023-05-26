//
//  UserModel.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 26/05/23.
//

import Foundation
import FirebaseFirestore

class UserModel : ObservableObject {
    @Published var usersList = [UserStruct]()
    
    let db = Firestore.firestore()
    
    init() {
        Task {
            if let users = await getData() {
                DispatchQueue.main.async {
                    self.usersList = users
                }
            }
        }
    }
    
    func getData() async -> [UserStruct]? {
        do {
            let querySnapshot = try await db.collection("equipo").getDocuments()
            
            var UsersArr = [UserStruct]()
            
            for document in querySnapshot.documents {
                let data = document.data()
                
                let email = data["email"] as? String ?? ""
                let firstName = data["firstName"] as? String ?? ""
                let lastName = data["lastName"] as? String ?? ""
                let useButtons = data["useButtons"] as? Bool ?? false
                let usePoseEstimation = data["usePoseEstimation"] as? Bool ?? false
                let useVoiceOver = data["useVoiceOver"] as? Bool == false
                let fontSize = data["fontSize"] as? Float ?? 18
                let buttonSize = data["buttonSize"] as? Float ?? 350
                let cardSize = data["cardSize"] as? Float ?? 350
                let rows = data["rows"] as? Int ?? 3
                let columns = data["columns"] as? Int ?? 3
                
                let id = document.documentID
                
                let unEquipo = UserStruct(id: id, email: email, firstName: firstName, lastName: lastName, useButtons: useButtons, usePoseEstimation: usePoseEstimation, useVoiceOver: useVoiceOver, fontSize: fontSize, buttonSize: buttonSize, cardSize: cardSize, rows: rows, columns: columns)
                UsersArr.append(unEquipo)
            }
            return UsersArr
        }
        catch {
            print("ERROR")
        }
        return nil
    }
    
    func updateData(anUser : UserStruct) async -> String {
        do {
            try await db.collection("user").document(anUser.id).setData(["email": anUser.email, "firstName": anUser.firstName, "lastName": anUser.lastName, "useButtons": anUser.useButtons, "usePoseEstimation": anUser.usePoseEstimation, "useVoiceOver": anUser.useVoiceOver, "fontSize": anUser.fontSize, "buttonSize": anUser.buttonSize, "cardSize": anUser.cardSize, "rows": anUser.rows, "columns": anUser.columns])
        }
        catch {
            return "Error al actualizar la información"
        }
        return "Ok"
    }
}
