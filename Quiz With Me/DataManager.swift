//
//  DataManager.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 04.06.21.
//

import Firebase
import FirebaseFirestoreSwift
import PromiseKit

// Needed to send an error message when the creation of a new game fails
enum DataManagerError: Error {
    case gameCreationFailed(String)
}

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
            self.addUserToList(uid: user.userID)
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
    
    func usernameAlreadyExists(username: String) -> Promise<Bool> {
        return Promise { promise in
            Firestore.firestore().collection("users").whereField("username", isEqualTo: username).getDocuments() { querySnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    promise.fulfill(true)
                    return
                }
                if let documents = querySnapshot?.documents {
                    if documents.count != 0 {
                        promise.fulfill(true)
                    } else {
                        promise.fulfill(false)
                    }
                }
            }
        }
    }
    
    func getGame(gameID: String) -> Promise<(QuizGame?, String?)> {
        var quizGame: QuizGame? = nil
        var id: String? = nil
        return Promise { promise in
            Firestore.firestore().collection("games").document(gameID).getDocument() { documentSnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                if let document = documentSnapshot {
                    do {
                        quizGame = try document.data(as: QuizGame.self)
                        id = document.documentID
                    } catch {
                        fatalError("Couldn't convert result to a game. This should never happen.")
                    }
                }
                promise.fulfill((quizGame, id))
            }
        }
    }
    
    func getGames(gameIDs: [String]) -> Promise<[String: QuizGame]?> {
        var fetchedGames: [String: QuizGame] = [:]
        return Promise { promise in
            for index in 0..<gameIDs.count {
                _ = self.getGame(gameID: gameIDs[index]).done { (response: (QuizGame?, String?)) in
                    if response.0 == nil || response.1 == nil {
                        promise.fulfill(nil)
                    }
                    fetchedGames[response.1!] = response.0!
                    if fetchedGames.count == gameIDs.count {
                        promise.fulfill(fetchedGames)
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
    
    func getQuestion(questionID: String) -> Promise<QuizQuestion?> {
        var question: QuizQuestion? = nil
        return Promise { promise in
            Firestore.firestore().collection("questions").document(questionID).getDocument() { document, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                do {
                    question = try document?.data(as: QuizQuestion.self)
                } catch {
                    fatalError("This should never happen!")
                }
                promise.fulfill(question)
            }
        }
    }
    
    private func getUserDocumentID(uid: String) -> Promise<String?> {
        var documentID: String? = nil
        return Promise { promise in
            Firestore.firestore().collection("users").whereField("userID", isEqualTo: uid).getDocuments() { querySnapshot, error in
                        if let error = error {
                            print(error.localizedDescription)
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
    
    func incrementProgress(gameId: String, playerProgress: String) -> Void {
        let db = Firestore.firestore()
        db.collection("games").document(gameId).updateData([playerProgress: FirebaseFirestore.FieldValue.increment(Int64(1))])
    }
    
    func incrementPoints(gameId: String, playerPoints: String) -> Void {
        let db = Firestore.firestore()
        db.collection("games").document(gameId).updateData([playerPoints: FirebaseFirestore.FieldValue.increment(Int64(1))])
    }

    func createNewGame() throws -> Promise<(String, QuizGame)?> {
        var userIDs: [String] = []
        var ownUID: String = ""
        var othersUID: String = ""
        var ownUsername: String = ""
        var othersUsername: String = ""
        var quizGame: QuizGame?
        var gameID: String = ""
        var ownUserDocumentID: String = ""
        var othersUserDocumentID: String = ""
        
        return Promise { promise in
            _ = getUserIDs().then { (response: [String]?) -> Promise in
                if response == nil {
                    throw DataManagerError.gameCreationFailed("Failed to get all userIDs from the DB.")
                }
                userIDs = response!
                
                if let ownID = Auth.auth().currentUser?.uid {
                    ownUID = ownID
                } else {
                    throw DataManagerError.gameCreationFailed("Method was called, though no user is signed in.")
                }
                let ownIndex = userIDs.firstIndex(of: ownUID)
                if ownIndex == nil {
                    throw DataManagerError.gameCreationFailed("Own userID was not included in all userIDs.")
                }
                var choosenIndex: Int = Int.random(in: 0..<userIDs.count)
                while(ownIndex == choosenIndex) {
                                    choosenIndex = Int.random(in: 0..<userIDs.count)
                                }
                othersUID = userIDs[choosenIndex]
                return self.getUser(uid: ownUID)
            }.then { (response: QuizUser?) -> Promise in
                if response == nil {
                    throw DataManagerError.gameCreationFailed("Couldn't get own user.")
                }
                ownUsername = response!.username
                return self.getUser(uid: othersUID)
            }.then { (response: QuizUser?) -> Promise in
                if response == nil {
                    throw DataManagerError.gameCreationFailed("Couldn't get opponent user.")
                }
                othersUsername = response!.username
                quizGame = QuizGame(nameP1: ownUsername, nameP2: othersUsername)
                return self.getGameQuestions()
            }.then { (response: [String]?) -> Promise in
                if quizGame == nil || response == nil {
                    throw DataManagerError.gameCreationFailed("Failed to get questions for the game.")
                }
                quizGame?.questionIDs = response!
                
                // Store the game in the data base
                do {
                    let document: DocumentReference = try Firestore.firestore().collection("games").addDocument(from: quizGame)
                    gameID = document.documentID
                } catch {
                    throw DataManagerError.gameCreationFailed("Couldn't upload game to DB.")
                }
                return self.getUserDocumentID(uid: ownUID)
            }.then { (response: String?) -> Promise in
                if response == nil {
                    throw DataManagerError.gameCreationFailed("Couldn't get documentID from own user from DB")
                }
                ownUserDocumentID = response!
                return self.getUserDocumentID(uid: othersUID)
            }.done { (response: String?) -> Void in
                if response == nil {
                    throw DataManagerError.gameCreationFailed("Couldn't get documentID from opponent from DB.")
                }
                othersUserDocumentID = response!
                Firestore.firestore().collection("users").document(ownUserDocumentID).updateData([
                            "gameIDs": FieldValue.arrayUnion([gameID])
                ])
                Firestore.firestore().collection("users").document(othersUserDocumentID).updateData([
                            "gameIDs": FieldValue.arrayUnion([gameID])
                ])
                if let game = quizGame {
                    promise.fulfill((gameID, game))
                } else {
                    throw DataManagerError.gameCreationFailed("The quiz game was nil after the whole process of creation")
                }
            }
        }
    }
    
}

