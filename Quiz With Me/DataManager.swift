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
    private let generalDocument = "1BKfvFtdI2WZPQmKt9p1"
    
    private struct GeneralInfo: Codable {
        var userIDs: [String]
        var questionIDs: [String]
    }
    
    func addUserToFireStore(user: QuizUser) {
        let db = Firestore.firestore()
        do {
            _ = try db.collection("users").addDocument(from: user)
        } catch {
            fatalError("Unable to add user to database: \(error.localizedDescription)")
        }
    }
    
    func getUser(uid: String, completion: @escaping (_: QuizUser?) -> Void) -> Void {
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
    
    func addUserToList(uid: String) -> Void {
        Firestore.firestore().collection("general").document(generalDocument).updateData([
            "userIDs": FieldValue.arrayUnion([uid])
        ])
    }
    
    func getUserIDs(completion: @escaping (_: [String]?) -> Void) -> Void {
        var userIDs: [String]? = nil
        Firestore.firestore().collection("general").document(generalDocument).getDocument() { document, error in
            if let error = error {
                print(error.localizedDescription)
            }
            do {
                userIDs = try document?.data(as: GeneralInfo.self)?.userIDs
                completion(userIDs)
            } catch {
                fatalError("This should never happen!")
            }
        }
    }
    
    func getQuestionIDs(completion: @escaping (_: [String]?) -> Void) -> Void {
        var questionIDs: [String]? = nil
        Firestore.firestore().collection("general").document(generalDocument).getDocument() { document, error in
            if let error = error {
                print(error.localizedDescription)
            }
            do {
                questionIDs = try document?.data(as: GeneralInfo.self)?.questionIDs
                completion(questionIDs)
            } catch {
                fatalError("This should never happen!")
            }
        }
    }
    
    func createNewGame() -> QuizGame? {
        // Handles if the current database operation is completed
        var finished: Bool = false
        
        // Get all userIDs that are available
        var userIDs: [String]? = nil
        getUserIDs() { resultUserIDs in
            if let ids = resultUserIDs {
                userIDs = ids
            } else {
                fatalError("Couldn't get userIDs during game creation process")
            }
            finished = true
        }
        while(!finished) {}
        
        // If no users were returned, we can't create a game
        guard let allUserIDs = userIDs else {
            return nil
        }
        
        // Get the ID of the user who is creating the game, if no ID is set, return with nil
        guard let ownID = Auth.auth().currentUser?.uid else {
            return nil
        }
        // Choose a random ID from userIDs that is not the own users ID
        guard let ownIndex = allUserIDs.firstIndex(of: ownID) else {
            return nil
        }
        var choosenIndex: Int = Int.random(in: 0..<allUserIDs.count)
        while(ownIndex == choosenIndex) {
            choosenIndex = Int.random(in: 0..<allUserIDs.count)
        }
        let choosenUserID = allUserIDs[choosenIndex]
        
        // Get both usernames to create a QuizGame instance
        var ownUsername: String? = nil
        var othersUsername: String? = nil
        finished = false
        getUser(uid: ownID) { quizUser in
            if let username = quizUser?.username {
                ownUsername = username
            }
            finished = true
        }
        
        while(!finished) {}
        finished = false
        
        getUser(uid: choosenUserID) { quizUser in
            if let username = quizUser?.username {
                othersUsername = username
            }
            finished = true
        }
        while(!finished) {}
        
        // Check if both users have got an username in the database
        guard let p1Name = ownUsername else {
            return nil
        }
        guard let p2Name = othersUsername else {
            return nil
        }
        
        // Create the new game instance
        let quizGame = QuizGame(nameP1: p1Name, nameP2: p2Name)
        
        // Add this game to fire store and save its document ID
        var documentID: String? = nil
        do {
            let document: DocumentReference = try Firestore.firestore().collection("games").addDocument(from: quizGame)
            documentID = document.documentID
        } catch {
            return nil
        }
        guard let gameID = documentID else {
            return nil
        }
        
        var ownUserDocumentID: String? = nil
        var othersUserDocumentID: String? = nil
        
        finished = false
        
        Firestore.firestore().collection("users").whereField("userID", isEqualTo: ownID).getDocuments() { querySnapshot, error in
            if let _ = error {
                print(error?.localizedDescription)
            }
            if let documents = querySnapshot?.documents {
                if documents.count != 1 {
                } else {
                    ownUserDocumentID = documents[0].documentID
                }
            }
            finished = true
        }
                
        while(!finished) {}
        finished = false
        
        Firestore.firestore().collection("users").whereField("userID", isEqualTo: choosenUserID).getDocuments() { querySnapshot, error in
            if let _ = error {
                print(error?.localizedDescription)
            }
            if let documents = querySnapshot?.documents {
                if documents.count != 1 {
                } else {
                    othersUserDocumentID = documents[0].documentID
                }
            }
            finished = true
        }
        
        guard let ownUserDocument = ownUserDocumentID else {
            return nil
        }
        guard let othersUserDocument = othersUserDocumentID else {
            return nil
        }
        
        Firestore.firestore().collection("users").document(ownUserDocument).updateData([
            "gameIDs": FieldValue.arrayUnion([gameID])
        ])
        Firestore.firestore().collection("users").document(othersUserDocument).updateData([
            "gameIDs": FieldValue.arrayUnion([gameID])
        ])
        return quizGame
    }

}
