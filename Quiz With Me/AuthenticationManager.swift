//
//  AuthenticationManager.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 13.05.21.
//

import Firebase
import FirebaseFirestoreSwift
import Combine

class AuthenticationManager {
    
    func signupWith(username: String, email: String, and password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let result = authResult {
                self.addUserToFireStore(user: QuizUser(userID: result.user.uid, username: username))
            }
        }
    }
    
    func loginWith(email: String, and password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            /*guard let strongSelf = self else {
                return
            }*/
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func addUserToFireStore(user: QuizUser) {
        let db = Firestore.firestore()
        do {
            _ = try db.collection("user").addDocument(from: user)
        } catch {
            fatalError("Unable to add user to database: \(error.localizedDescription)")
        }
    }
}
