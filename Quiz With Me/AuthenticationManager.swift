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
    
    
    // Static property for using as a singleton
    static let shared = AuthenticationManager()
    
    func signupWith(username: String, email: String, and password: String, completion: @escaping(_ res: Bool, _ err: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                completion(false, error)
            }
            if let result = authResult {
                self.addUserToFireStore(user: QuizUser(userID: result.user.uid, username: username))
                completion(true, nil)
            }
        }
    }
    
    func loginWith(email: String, and password: String, completion: @escaping(_ res: Bool, _ err: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            /*guard let strongSelf = self else {
                return
            }*/
            guard let error = error else {
                completion(true, nil)
                return
            }
            completion(false, error)
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
