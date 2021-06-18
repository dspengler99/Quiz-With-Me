//
//  QuizGame.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 30.05.21.
//

import Foundation

public class QuizGame: Codable, Equatable {
    var nameP1: String
    var nameP2: String
    var progressP1: Int
    var progressP2: Int
    var pointsP1: Int
    var pointsP2: Int
    var questionIDs: [String]
    
    init(nameP1: String, nameP2: String, progressP1: Int = 0, progressP2: Int = 0, pointsP1: Int = 0, pointsP2: Int = 0, questions: [String] = []) {
        self.nameP1 = nameP1
        self.nameP2 = nameP2
        self.progressP1 = progressP1
        self.progressP2 = progressP2
        self.pointsP1 = pointsP1
        self.pointsP2 = pointsP2
        self.questionIDs = questions
    }
    
    public static func ==(lhs: QuizGame, rhs: QuizGame) -> Bool {
        return lhs.nameP1 == rhs.nameP1 && lhs.nameP2 == rhs.nameP2
    }
}
