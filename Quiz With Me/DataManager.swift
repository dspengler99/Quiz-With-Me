//
//  DataManager.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 04.06.21.
//

import Firebase
import FirebaseFirestoreSwift

class DataManager {
    static let shared: DataManager = DataManager()
    
    func getUser(uid: String) -> Void {
        print(uid)
        Firestore.firestore().collection("users").whereField("userID", isEqualTo: uid).getDocuments() { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let documents = querySnapshot?.documents {
                print("Found \(documents.count)")
            }
        }
    }
}
