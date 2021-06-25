//
//  AuthenticationManager.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 13.05.21.
//

import Firebase
import FirebaseFirestoreSwift
import Combine

// Needed to send an error message when the registration succeeds, but the login afterwards fails
enum AuthenticationError: Error {
    case loginFailed(String)
}

/**
 This class holds all methods which are required to work with the Authentication Service of Firebase
 */
class AuthenticationManager {
    
    
    /// Static property for using the class as a singleton
    static let shared = AuthenticationManager()
    
    /**
     Creates a user in the Authentication Service and adds the object to the Firestore-DB as well so information like the username can be stored.
     
     The method also tries to login the user after the successfull registration.
     
     - Parameter username: The username for the user that should be created.
     - Parameter email: The provided email-address of the user.
     - Parameter password: The password the user has choosen.
     - completion: Has an error and a boolean values as an input. The error is nil when no error has happened and the boolean is true when the registration has succeeded.
     */
    func signupWith(username: String, email: String, and password: String, completion: @escaping(_ res: Bool, _ err: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                completion(false, error)
            }
            if let result = authResult {
                DataManager.shared.addUserToFireStore(user: QuizUser(userID: result.user.uid, username: username))
                Auth.auth().signIn(withEmail: email, password: password) {auth, err in
                    if let _ = err {
                        completion(false, AuthenticationError.loginFailed("Registrierung erfolgreich, aber der Login ist fehlgeschlagen. Versuche dich auf der Login-Seite anzumelden."))
                    } else {
                        completion(true, nil)
                    }
                }
            }
        }
    }
    
    /**
     This method signs the user in his account.
     
     - Parameter email: The email the user wants to sign in with.
     - Parameter password: The password the user provided for the login.
     - Parameter completion: Gets a boolean value and an optional error as input. The boolean is true when the login succeeded. The completion contains code that will be executed after the operations from the Authentication Service.
     */
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
    
    /**
     Checks if a user is signed in on the used device
     
     - returns: Returns true, if the user is signed in, false if not.
     */
    func foundCredentials() -> Bool {
        return Auth.auth().currentUser?.uid != nil
    }
    
    /**
     This method signs the user out of his account.
     
     - returns: Returns true, if the signout was successfull, false if not.
     */
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
        } catch {
            return false
        }
        return true
    }
    
    /**
     Gets the Mail-address of the currently signed in user. This method should be only called when a user should be signed in, othervice the return value will be an empty string.
     
     - returns: A string with the email-address if a user is signed in. Othervice an empty string will be returned.
     */
    func getEMail() -> String {
        guard let email = Auth.auth().currentUser?.emaila else {
            return ""
        }
        return email
    }
}
