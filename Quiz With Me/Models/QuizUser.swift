//
//  User.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 13.05.21.
//

/**
 This class holds all information that are required for a User in the game.
 
 The structure of the properties represents, how a User is stored in the data base as a document.
 */
public class QuizUser: Codable, Equatable {
    var userID: String
    var username: String
    var totalGames: Int
    var wonGames: Int
    var lostGames: Int
    var gameIDs: [String]
    
    
    /**
     Initializes a user. If no game-ID, total games, won games, or lost games are provided, this value are filled with default values of 0 or with an empty array in the case of game-IDs.
     
     This way there are less arguments needed, when creating a fresh user in the registration process.
     */
    init(userID: String, username: String, totalGames: Int = 0, wonGames: Int = 0, lostGames: Int = 0, gameIDs: [String] = []) {
        self.userID = userID
        self.username = username
        self.totalGames = totalGames
        self.wonGames = wonGames
        self.lostGames = lostGames
        self.gameIDs = gameIDs
    }
    
    /**
     Method needed to conform to Equatable. This method compares two quiz users and returns true when they are equal.
     
     - Parameter lhs: A object of type `QuizUser` that should be compared with another one.
     - Parameter rhs: The other quiz user that should be compared against the lhs.
     - returns: True if lhs and rhs are equal, else false.
     */
    public static func ==(lhs: QuizUser, rhs: QuizUser) -> Bool {
        return lhs.username == rhs.username && lhs.gameIDs == rhs.gameIDs && lhs.totalGames == rhs.totalGames && lhs.wonGames == rhs.wonGames && lhs.lostGames == rhs.lostGames && lhs.userID == rhs.userID
    }
}
