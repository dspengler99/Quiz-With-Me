//
//  User.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 13.05.21.
//

public class QuizUser: Codable {
    var userID: String
    var username: String
    var totalGames: Int
    var wonGames: Int
    var gameIDs: [String]
    
    init(userID: String, username: String, totalGames: Int = 0, wonGames: Int = 0, gameIDs: [String] = []) {
        self.userID = userID
        self.username = username
        self.totalGames = totalGames
        self.wonGames = wonGames
        self.gameIDs = gameIDs
    }
}
