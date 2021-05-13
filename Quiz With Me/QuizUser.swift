//
//  User.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 13.05.21.
//

public class QuizUser: Codable {
    var userID: String
    var username: String
    
    init(userID: String, username: String) {
        self.userID = userID
        self.username = username
    }
}
