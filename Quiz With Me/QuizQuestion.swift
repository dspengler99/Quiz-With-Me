//
//  QuizQuestion.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 03.06.21.
//

import Foundation

public class QuizQuestion {
    var question: String
    var answers: [String]
    var rightAnswer: String
    
    init(question: String, answers: [String], rightAnswer: String) {
        self.question = question
        self.answers = answers
        self.rightAnswer = rightAnswer
    }
    
    func checkAnswer(answer: String) -> Bool {
        if(answer == rightAnswer) {
            return true
        }
        return false
    }
}
