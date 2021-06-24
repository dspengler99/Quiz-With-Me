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

/**
 This class handles all data base operation that are not related to the Authentication service
 
 All methods for getting users, creating new games, etc. are defined here.
 */
class DataManager {
    /**
     This property is used to use the singleton pattern. That means that no instance of the class is required besides `shared`
     */
    static let shared: DataManager = DataManager()

    /**
     This property holds the document-ID for the general document.
     
     This ID won't change and is the only required to work in the general collection, because this collection holds just one document with the specified ID
     */
    private let generalDocument = "1BKfvFtdI2WZPQmKt9p1"
    
    /**
     This struct holds the data layout for the general document.
     
     This Type is needed for easy parsing from Firebase
     */
    private struct GeneralInfo: Codable {
        var userIDs: [String]
        var questionIDs: [String]
    }
    
    /**
     This Method adds a new user to the `users`-collection from Firestore.
     
     - Parameter quizUser: The `QuizUser`-object that should be added to the collection
     */
    func addUserToFireStore(user: QuizUser) {
        let db = Firestore.firestore()
        do {
            _ = try db.collection("users").addDocument(from: user)
            self.addUserToList(uid: user.userID)
        } catch {
            fatalError("Unable to add user to database: \(error.localizedDescription)")
        }
    }
    
    /**
     This method gets a user from the Firestore-database. Therefor a user-ID is needed to find the right document.
     
     If the query finds more then one document in the Firebase, no user is returned. In a real use this should never happen, because Firebase creates the user-IDs and therefore there shouldn't be any duplicates.
     
     If the received user cannot be converted to the type of `QuizUser` the App will crash. This can only happen, when the data format in the DB has changed and the class `QuizUser` is not updated to that format. Another reason for the crash could be, that we have adjusted `QuizUser`, but there are still old formats in the DB.
     
     - Parameter uid: The user-ID for which the user should be returned
     
     - returns: Returns a Promise with a quiz user or `nil` when an error occured.
     */
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
    
    /**
     This method checks if a given user already exists. This method is needed, to check for duplicate user names during the registration process.
     
     - Parameter username: The username which should be checked for existance
     
     - returns: Returns a promise with a value of true, if the user exists or an error has happened. False is returned othervice
     */
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
                    } else if documents.count == 0 {
                        promise.fulfill(false)
                    }
                }
            }
        }
    }
    
    /**
     This method gets the document-ID of a user in the Firebase-DB.
     
     It is needed in other methods to update a specific user. Please note that the already mentioned `userID` or `uid` are not the same as the document-ID of an user.
     
     - Parameter userID: The userID for which the document-ID should be returned.
     
     - returns: Returns a promise with the requested document-ID. `nil` is returned in case of an error, or if more when one document were found with the same user-ID (This should never happen in real situations).
     */
    func getUserDocumentID(userID: String) -> Promise<String?> {
        return Promise { promise in
            Firestore.firestore().collection("users").whereField("userID", isEqualTo: userID).getDocuments() { querySnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    promise.fulfill(nil)
                    return
                }
                if let documents = querySnapshot?.documents {
                    if documents.count == 1 {
                        promise.fulfill(documents[0].documentID)
                    } else {
                        promise.fulfill(nil)
                    }
                }
            }
        }
    }
    
    /**
     This method is used in order to delete a game from an user. The deletion just happens to finished games when the user has seen his results.
     
     This method is not deleting the game object itself from the DB. It just removes the game-ID from the users `gameIDs` field, so the user cannot access the game anymore. For deleting the whole game additional algorithms and information in the game itself would be needed, so the game would not be deleted before both user have seen the game result.
     
     - Parameter userID: The userID, which specifies from which user the game-ID should be deleted.
     - Parameter gameID: The game-ID that should be deleted from the user with `userID`.
     - Parameter completion: A closure which contains code which should be executed after the deletion.
     */
    func deleteGameFromUser(userID: String, gameID: String, completion: @escaping () -> Void) -> Void {
        _ = getUserDocumentID(userID: userID).done { response in
            guard let documentID = response else {
                return
            }
            Firestore.firestore().collection("users").document(documentID).updateData([
                "gameIDs": FieldValue.arrayRemove([gameID])
            ])
            completion()
        }
    }
    
    /**
     This method updates the won, lost and or total games of a user.
     
     The parameters of the function are determening which fields will be incremented.
     
     - Parameter userID: The user-ID for the user that should be updated.
     - Parameter hasWon: If this parameter is true, `wonGames` will be updated. If it is false, `lostGames` will be updated. In case of `nil` the game ended with a draw and just `totalGames` will be updated. The property `totalGames` will be updated in any case.
     */
    func updateStatistics(userID: String, hasWon: Bool?) -> Void {
        _ = getUserDocumentID(userID: userID).done { response in
            guard let documentID = response else {
                fatalError("Couldn't get documentID from user.")
            }
            Firestore.firestore().collection("users").document(documentID).updateData([
                "totalGames": FieldValue.increment(Int64(1))
            ])
            if hasWon == true {
                Firestore.firestore().collection("users").document(documentID).updateData([
                    "wonGames": FieldValue.increment((Int64(1)))
                ])
            } else if hasWon == false {
                Firestore.firestore().collection("users").document(documentID).updateData([
                    "lostGames": FieldValue.increment(Int64(1))
                ])
            }
        }
    }
    
    /**
     This method gets a game by the specified id from the DB.
     
     A fatal error is triggered, when the game from the DB cannot be converted to the type of `QuizGame`.
     
     - Parameter gameID: The game-ID for which the game should be returned.
     
     - returns: Returns a promise with a `QuizGame`. It will be `nil` when something goes wrong.
     */
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
    
    /**
     This method returns all games for the specified game-IDs.
     
     To return all games a for loop calls `getGame` for every single provided game-ID. Inside the closure-part the game is added to the local dictionary. If this dictionary contains as many elements as the parameter `gameIDs` the dict is returned with `promise.fulfill`.
     
     - Parameter gameIDs: The game-IDs for which the games should be returned.
     
     - returns: A promise with a dictionary, which contains the game-ID for a single game as the key and the coresponding game as the value. `nil` is returned if only one game couldn't be fetched from the DB.
     */
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
    
    /**
     This method adds a user to the general-collection in the DB.
     
     The user-IDs in this document are needed to create new games without the requirement to fetch all users with there whole data. Please see `createNewGame` for the use of this function.
     
     - Parameter uid: The user-ID that should be added to the collection. It is the same as the field `userID` of an object of type `QuizUser`
     */
    func addUserToList(uid: String) -> Void {
        Firestore.firestore().collection("general").document(generalDocument).updateData([
            "userIDs": FieldValue.arrayUnion([uid])
        ])
    }
    
    /**
     This method returns all existing user-IDs which are contained in the general collection of Firestore.
     
     - returns: Returns an Array with all found user-IDs. `nil` is returned if anything goes wrong.
     */
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
    
    /**
     This method gets all question-IDs that exist in the general collection of Firebase.
     
     - Parameter completion: A completion-handler that will be executed, as soon as the Firebase operation has finished. As an input it will receive the found question-IDs. `nil` is passed in, when something goes wrong.
     */
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
    
    /**
     This method gets the questions for a single game. In order to achive this, it queries all question-IDs and shuffles the received array. After this a new array with just the first 10 elements is taken and returned.
     
     - returns: A promise with the selected questions. `nil` is contained in the promise, if anything goes wrong.
     */
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
    
    /**
     Gets a single question, converts it to `QuizQuestion` and returns it.
     
     - Parameter questionID: The ID of a question for which the question should be returned. Please note that the questionID is also the document-ID of the question and not an extra field inside a `QuizQuestion`-object.
     */
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
    
    /**
     Updates the progress of a player in a specified game. This is needed when playing games to synchronize the progress with the DB after each answered question.
     
     The progress is always incremented by one, because the method is called after every question, so there is no other value besides 1 for the increment function
     - Parameter gameId: The game-ID for which the progress of a player should be incremented.
     - Parameter playerProgress: contains `nameP1` or `nameP2`, depending on which progress needs to be updated.
     */
    func incrementProgress(gameId: String, playerProgress: String) -> Void {
        let db = Firestore.firestore()
        db.collection("games").document(gameId).updateData([playerProgress: FirebaseFirestore.FieldValue.increment(Int64(1))])
    }
    
    /*
     Increments the points for the specified player in the specified game.
     
     The points will be always incremented by one, if this method gets called, because it increments the points for one answered question.
     
     - Parameter gameId: the ID of an game which should be updated.
     - Parameter playerProgress: Contains `nameP1` or `nameP2`depending on which player should be updated in the game.
     */
    func incrementPoints(gameId: String, playerPoints: String) -> Void {
        let db = Firestore.firestore()
        db.collection("games").document(gameId).updateData([playerPoints: FirebaseFirestore.FieldValue.increment(Int64(1))])
    }

    /**
     This method creates a new game in the firebase and updates all other needed documents, such as the user documents of both selected players.
     
     - Throws: Throws an error when something has gone wrong.
     - returns: Returns the game-ID of the new game and the game itself. This values are packed in a tupple which could be nil
     */
    func createNewGame() throws -> Promise<(String, QuizGame)?> {
        // Declaring variables which will be needed later.
        // We are not using optionals here for better reading later on
        var userIDs: [String] = []
        var ownUID: String = ""
        var othersUID: String = ""
        var ownUsername: String = ""
        var othersUsername: String = ""
        // This is an optional to later just return this variable whatever its value is
        var quizGame: QuizGame?
        var gameID: String = ""
        var ownUserDocumentID: String = ""
        var othersUserDocumentID: String = ""
        
        // The return statement begins here and contains all other needed calls.
        return Promise { promise in
            // First we need al user-IDs to find another player
            _ = getUserIDs().then { (response: [String]?) -> Promise in
                if response == nil {
                    throw DataManagerError.gameCreationFailed("Failed to get all userIDs from the DB.")
                }
                userIDs = response!
                
                // We need to get our own ID for later stuff
                if let ownID = Auth.auth().currentUser?.uid {
                    ownUID = ownID
                } else {
                    throw DataManagerError.gameCreationFailed("Method was called, though no user is signed in.")
                }
                
                // Find our own index in the array of user-IDs, sow we won't ending up playing against our selfes.
                let ownIndex = userIDs.firstIndex(of: ownUID)
                
                // Check if our ID was contained in the array with all user-IDs
                // In real situations this should never happen
                if ownIndex == nil {
                    throw DataManagerError.gameCreationFailed("Own userID was not included in all userIDs.")
                }
                
                // Randomly select an index from the user-IDs. The ID at the choosen index specifies the other player with whom the game will be created.
                var choosenIndex: Int = Int.random(in: 0..<userIDs.count)
                // When the choosenIndex is the same as our index we need to repeat the randomized search.
                while(ownIndex == choosenIndex) {
                    choosenIndex = Int.random(in: 0..<userIDs.count)
                }
                
                // After finding a valid player we remember the ID
                othersUID = userIDs[choosenIndex]
                
                // Get the user-object of our own user from the DB
                return self.getUser(uid: ownUID)
            }.then { (response: QuizUser?) -> Promise in
                if response == nil {
                    throw DataManagerError.gameCreationFailed("Couldn't get own user.")
                }
                // Setting our username
                ownUsername = response!.username
                
                // Get the user object of the other user
                return self.getUser(uid: othersUID)
            }.then { (response: QuizUser?) -> Promise in
                if response == nil {
                    throw DataManagerError.gameCreationFailed("Couldn't get opponent user.")
                }
                // Set the oponents username
                othersUsername = response!.username
                
                // Initialize our quizGame-Variable, now that we have the usernames
                quizGame = QuizGame(nameP1: ownUsername, nameP2: othersUsername)
                
                // Get the questions for this game.
                return self.getGameQuestions()
            }.then { (response: [String]?) -> Promise in
                if quizGame == nil || response == nil {
                    throw DataManagerError.gameCreationFailed("Failed to get questions for the game.")
                }
                
                // Setting the received IDs for the questions in our created game object
                quizGame?.questionIDs = response!
                
                // Store the game in the data base
                do {
                    let document: DocumentReference = try Firestore.firestore().collection("games").addDocument(from: quizGame)
                    // The document-ID will be needed for inserting the game in both users.
                    gameID = document.documentID
                } catch {
                    throw DataManagerError.gameCreationFailed("Couldn't upload game to DB.")
                }
                
                // Get the document-ID for our own user.
                return self.getUserDocumentID(userID: ownUID)
            }.then { (response: String?) -> Promise in
                if response == nil {
                    throw DataManagerError.gameCreationFailed("Couldn't get documentID from own user from DB")
                }
                ownUserDocumentID = response!
                
                // Get the document-ID of the other user
                return self.getUserDocumentID(userID: othersUID)
            }.done { (response: String?) -> Void in
                if response == nil {
                    throw DataManagerError.gameCreationFailed("Couldn't get documentID from opponent from DB.")
                }
                othersUserDocumentID = response!
                
                // Now update both documents so that they include the new game.
                Firestore.firestore().collection("users").document(ownUserDocumentID).updateData([
                            "gameIDs": FieldValue.arrayUnion([gameID])
                ])
                Firestore.firestore().collection("users").document(othersUserDocumentID).updateData([
                            "gameIDs": FieldValue.arrayUnion([gameID])
                ])
                // Checking if the game is initialized
                // If yes, we return it
                // If not, the app will crash
                if let game = quizGame {
                    promise.fulfill((gameID, game))
                } else {
                    throw DataManagerError.gameCreationFailed("The quiz game was nil after the whole process of creation")
                }
            }
        }
    }
    
}

