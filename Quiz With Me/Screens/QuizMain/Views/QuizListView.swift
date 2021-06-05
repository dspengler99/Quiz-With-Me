//
//  QuizListView.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 30.05.21.
//

import SwiftUI

struct QuizListView: View {
     var quizGames: [QuizGame]

     var body: some View {
         ScrollView(.vertical) {
             VStack(spacing: 15) {
                ForEach(0..<quizGames.count) { index in QuizItemCard(quizGame: quizGames[index])
                 }
             }
         }
     }
 }

 struct QuizListView_Previews: PreviewProvider {
     static var quizGames: [QuizGame] = [
         QuizGame(nameP1: "Tom", nameP2: "Kevin"),
         QuizGame(nameP1: "Tom", nameP2: "Thomas"),
         QuizGame(nameP1: "Tom", nameP2: "Justus")
     ]
     static var previews: some View {
         QuizListView(quizGames: quizGames)
     }
 }
