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
    var rightAnswer: Int
    
    init(question: String, answers: [String], rightAnswer: Int) {
        self.question = question
        self.answers = answers
        self.rightAnswer = rightAnswer
    }
}
