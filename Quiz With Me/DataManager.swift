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
    
    func getUser(uid: String, completion: @escaping (_: QuizUser?) -> Void) -> Void {
        print(uid)
        Firestore.firestore().collection("users").whereField("userID", isEqualTo: uid).getDocuments() { querySnapshot, error in
            if let _ = error {
                completion(nil)
                return
            }
            if let documents = querySnapshot?.documents {
                if documents.count != 1 {
                    completion(nil)
                } else {
                    do {
                        try completion(documents[0].data(as: QuizUser.self))
                    } catch {
                        fatalError("Could not convert user to user object. This should never happen.")
                    }
                }
            }
        }
    }
}
