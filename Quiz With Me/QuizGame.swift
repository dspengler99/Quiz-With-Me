//
//  QuizGame.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 30.05.21.
//

import Foundation

/**
 This class holds all information for a single game. The structure and types of the properties represent the structure in the collection `games`of a single document.
 */
public class QuizGame: Codable, Equatable {
    var nameP1: String
    var nameP2: String
    var progressP1: Int
    var progressP2: Int
    var pointsP1: Int
    var pointsP2: Int
    var questionIDs: [String]
    
    /**
     Initializes a new games. The constructor provides default values for the progress and the points of both players as well as question-IDs, so a minimum of arguments is required to create a new game.
     */
    init(nameP1: String, nameP2: String, progressP1: Int = 0, progressP2: Int = 0, pointsP1: Int = 0, pointsP2: Int = 0, questions: [String] = []) {
        self.nameP1 = nameP1
        self.nameP2 = nameP2
        self.progressP1 = progressP1
        self.progressP2 = progressP2
        self.pointsP1 = pointsP1
        self.pointsP2 = pointsP2
        self.questionIDs = questions
    }

    /**
     Method, needed to conform to the protocol Equatable. The method checks if two given games are equal.
     
     - Parameter lhs: The first object of type `QuizGame`
     - Parameter rhs: The second object of type `QuizGame`
     - returns: True if lhs and rhs are equal, else false.
     */
    public static func ==(lhs: QuizGame, rhs: QuizGame) -> Bool {
        return lhs.nameP1 == rhs.nameP1 && lhs.nameP2 == rhs.nameP2
    }
}
