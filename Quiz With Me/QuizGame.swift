//
//  QuizGame.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 30.05.21.
//

import Foundation

public class QuizGame {
     var gameID: String
     var name_p1: String
     var name_p2: String
     var progress_p1: Int
     var progress_p2: Int
     var gameDate: Date

     init(gameID: String, name_p1: String, name_p2: String) {
         self.gameID = gameID
         self.name_p1 = name_p1
         self.name_p2 = name_p2
         self.progress_p1 = 0
         self.progress_p2 = 0
         self.gameDate = Date()
     }
 }
