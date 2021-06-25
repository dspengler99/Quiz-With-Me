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
public class QuizUser: Codable {
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
}
