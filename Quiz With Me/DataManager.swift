//
//  DataManager.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 04.06.21.
//

import Firebase
import FirebaseFirestoreSwift
import PromiseKit

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
    
    /*func getQuestion(questionID: String, completion: @escaping (_: QuizQuestion?) -> Void) -> Void {
        Firestore.firestore().collection("questions").document(questionID).getDocument() { document, error in
            if let _ = error {
                completion(nil)
                return
            }
            let result = Result {
                try document?.data(as: QuizQuestion.self)
            }
            
            switch result {
            case .success(let question):
                if let question = question {
                    // A `Question` value was successfully initialized from the DocumentSnapshot.
                    completion(question)
                    //print("Question: \(question)")
                } else {
                    // A nil value was successfully initialized from the DocumentSnapshot,
                    // or the DocumentSnapshot was nil.
                    print("Document does not exist")
                }
            case .failure(let error):
                // A `Question` value could not be initialized from the DocumentSnapshot.
                print("Error decoding question: \(error)")
            }
        }
    }*/
    
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
    
    func getGameQuestions() -> Promise<[String]?> {
        var questionIDs: [String]? = nil
        var gameQuestionIDs: [String]? = nil
        return Promise { promise in
            getQuestionIDs() { resultQuestionIDs in
                if let ids = resultQuestionIDs {
                    questionIDs = ids
                    questionIDs?.shuffle()
                    gameQuestionIDs = Array((questionIDs?.prefix(10))!)
                } else {
                    fatalError("Couldn't get Question during game creation process")
                }
                promise.fulfill(gameQuestionIDs)
            }
    }
    }
    
    /*func createNewGame() -> QuizGame? {
        // Handles if the current database operation is completed
        var finished: Bool = false
        // Get all userIDs that are available
        var userIDs: [String]? = nil
        getUserIDs() { resultUserIDs in
            if let ids = resultUserIDs {
                userIDs = ids
                finished = true
            } else {
                fatalError("Couldn't get userIDs during game creation process")
            }
        }
        
        var choosenUser = ""
        var ownUID: String? = nil
        var ownUsername: String? = nil
        var othersUsername: String? = nil
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if finished {
                // If no users were returned, we can't create a game
                guard let allUserIDs = userIDs else {
                    return
                }
                // Get the ID of the user who is creating the game, if no ID is set, return with nil
                guard let ownID = Auth.auth().currentUser?.uid else {
                    return
                }
                ownUID = ownID
                // Choose a random ID from userIDs that is not the own users ID
                guard let ownIndex = allUserIDs.firstIndex(of: ownID) else {
                    return
                }
                var choosenIndex: Int = Int.random(in: 0..<allUserIDs.count)
                while(ownIndex == choosenIndex) {
                    choosenIndex = Int.random(in: 0..<allUserIDs.count)
                }
                let choosenUserID = allUserIDs[choosenIndex]
                choosenUser = choosenUserID
                
                // Get both usernames to create a QuizGame instance
                self.getUser(uid: ownID) { quizUser in
                    if let username = quizUser?.username {
                        ownUsername = username
                        finished = true
                    }
                }
                timer.invalidate()
            }
        }
        
        finished = false
        
        getUser(uid: choosenUser) { quizUser in
            if let username = quizUser?.username {
                othersUsername = username
                finished = true
            }
        }
        
        var gameIDvar: String? = nil
        var quizGameVar: QuizGame = QuizGame(nameP1: "", nameP2: "")
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if finished {
                // Check if both users have got an username in the database
                guard let p1Name = ownUsername else {
                    return
                }
                guard let p2Name = othersUsername else {
                    return
                }
                
                // Create the new game instance
                let quizGame = QuizGame(nameP1: p1Name, nameP2: p2Name)
                print("Test \(quizGame)")
                quizGameVar = quizGame
                
                // Add this game to fire store and save its document ID
                var documentID: String? = nil
                do {
                    let document: DocumentReference = try Firestore.firestore().collection("games").addDocument(from: quizGame)
                    documentID = document.documentID
                } catch {
                    return
                }
                guard let gameID = documentID else {
                    return
                }
                gameIDvar = gameID
                timer.invalidate()
            }
        }
        
        finished = false
        
        var ownUserDocumentID: String? = nil
        var othersUserDocumentID: String? = nil
        Firestore.firestore().collection("users").whereField("userID", isEqualTo: ownUID ?? "09vyY04nuheXh73jtkGPxxgmX3f1").getDocuments() { querySnapshot, error in
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
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if finished {
                
                timer.invalidate()
            }
        }
        
        Firestore.firestore().collection("users").whereField("userID", isEqualTo: "v7FKqYf4EXecWKDFNKNlHEnErbm2").getDocuments() { querySnapshot, error in
            if let _ = error {
                print(error?.localizedDescription)
            }
            if let documents = querySnapshot?.documents {
                if documents.count != 1 {
                } else {
                    othersUserDocumentID = documents[0].documentID
                }
            }
        }
        
        guard let ownUserDocument = ownUserDocumentID else {
            return nil
        }
        guard let othersUserDocument = othersUserDocumentID else {
            return nil
        }
        
        Firestore.firestore().collection("users").document(ownUserDocument).updateData([
            "gameIDs": FieldValue.arrayUnion([gameIDvar!])
        ])
        Firestore.firestore().collection("users").document(othersUserDocument).updateData([
            "gameIDs": FieldValue.arrayUnion([gameIDvar!])
        ])
        
        self.getGameQuestions() { questions in
            quizGameVar.questionIDs = questions
        }
        
        return quizGameVar
    }*/
}
