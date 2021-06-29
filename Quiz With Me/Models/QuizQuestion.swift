//
//  QuizQuestion.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 03.06.21.
//

import Foundation

/**
 This class represents a single question in the game.
 
 The structure of the properties represents the layout of a single document in the Firebase collection `questions`.
 */
public class QuizQuestion: Codable {
    var question: String
    var answers: [String]
    /// This property contains the right of the four strings in the answers-array. We do not just provide the index, because we wouldn't be able to shuffle the answers, when the question is shown to the user.
    var rightAnswer: String
    
    /**
     Initializes a question. The constructor is used, when getting questions from the Firestore-Db.
     */
    init(answers: [String], question: String, rightAnswer: String) {
        self.question = question
        self.answers = answers
        self.rightAnswer = rightAnswer
    }
    
    /**
     This method checks, if a given answer is the right one.
     
     - Parameter answer: The answer the user has given.
     - returns: Returns true in case of an right answer, false othervice.
     */
    func checkAnswer(answer: String) -> Bool {
        if(answer == rightAnswer) {
            return true
        }
        return false
    }
}
