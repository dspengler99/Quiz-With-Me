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
    
    func getUser(uid: String) -> Promise<QuizUser?> {
        var quizUser: QuizUser? = nil
        return Promise { promise in
            Firestore.firestore().collection("users").whereField("userID", isEqualTo: uid).getDocuments() { querySnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let documents = querySnapshot?.documents {
                    if documents.count == 1 {
                        do {
                            quizUser = try documents[0].data(as: QuizUser.self)
                        } catch {
                            fatalError("Could not convert user to user object. This should never happen.")
                        }
                    }
                }
                promise.fulfill(quizUser)
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
    
    func getUserIDs() -> Promise<[String]?> {
        var userIDs: [String]? = nil
        return Promise { promise in
            Firestore.firestore().collection("general").document(generalDocument).getDocument() { document, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                do {
                    userIDs = try document?.data(as: GeneralInfo.self)?.userIDs
                } catch {
                    fatalError("This should never happen!")
                }
                promise.fulfill(userIDs)
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
    
    private func getUserDocumentID(uid: String) -> Promise<String?> {
        var documentID: String? = nil
        return Promise { promise in
            Firestore.firestore().collection("users").whereField("userID", isEqualTo: uid).getDocuments() { querySnapshot, error in
                        if let _ = error {
                            print(error?.localizedDescription)
                        }
                        if let documents = querySnapshot?.documents {
                            if documents.count != 1 {
                            } else {
                                documentID = documents[0].documentID
                            }
                        }
                        promise.fulfill(documentID)
                }
            }

    }
    
    func createNewGame() -> Promise<QuizGame?> {
        var userIDs: [String] = []
        var ownUID: String = ""
        var othersUID: String = ""
        var ownUsername: String = ""
        var othersUsername: String = ""
        var gameQuestionIDs: [String] = []
        var quizGame: QuizGame?
        var gameID: String = ""
        var ownUserDocumentID: String = ""
        var othersUserDocumentID: String = ""
        
        return Promise { promise in
            getUserIDs().then { (response: [String]?) -> Promise in
                if response == nil {
                    promise.fulfill(nil)
                }
                userIDs = response!
                
                if let ownID = Auth.auth().currentUser?.uid {
                    ownUID = ownID
                } else {
                    promise.fulfill(nil)
                }
                let ownIndex = userIDs.firstIndex(of: ownUID)
                if ownIndex == nil {
                    promise.fulfill(nil)
                }
                var choosenIndex: Int = Int.random(in: 0..<userIDs.count)
                while(ownIndex == choosenIndex) {
                                    choosenIndex = Int.random(in: 0..<userIDs.count)
                                }
                othersUID = userIDs[choosenIndex]
                return self.getUser(uid: ownUID)
            }.then { (response: QuizUser?) -> Promise in
                if response == nil {
                    promise.fulfill(nil)
                }
                ownUsername = response!.username
                return self.getUser(uid: othersUID)
            }.then { (response: QuizUser?) -> Promise in
                if response == nil {
                    promise.fulfill(nil)
                }
                othersUsername = response!.username
                quizGame = QuizGame(nameP1: ownUsername, nameP2: othersUsername)
                return self.getGameQuestions()
            }.then { (response: [String]?) -> Promise in
                if quizGame == nil || response == nil {
                    promise.fulfill(nil)
                }
                quizGame?.questionIDs = response!
                
                // Store the game in the data base
                do {
                    let document: DocumentReference = try Firestore.firestore().collection("games").addDocument(from: quizGame)
                    gameID = document.documentID
                } catch {
                    promise.fulfill(nil)
                }
                return self.getUserDocumentID(uid: ownUID)
            }.then { (response: String?) -> Promise in
                if response == nil {
                    promise.fulfill(nil)
                }
                ownUserDocumentID = response!
                return self.getUserDocumentID(uid: othersUID)
            }.done { (response: String?) in
                if response == nil {
                    promise.fulfill(nil)
                }
                othersUserDocumentID = response!
                Firestore.firestore().collection("users").document(ownUserDocumentID).updateData([
                            "gameIDs": FieldValue.arrayUnion([gameID])
                ])
                Firestore.firestore().collection("users").document(othersUserDocumentID).updateData([
                            "gameIDs": FieldValue.arrayUnion([gameID])
                ])
                promise.fulfill(quizGame)
            }
        }
    }
    
}

