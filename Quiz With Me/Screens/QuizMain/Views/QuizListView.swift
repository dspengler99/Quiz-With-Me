//
//  QuizListView.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 27.05.21.
//

import SwiftUI

struct QuizListView: View {
    var quizGames: [QuizGame]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                ForEach(quizGames, id: \.self.gameID) { testGame in QuizItemCard(quizGame: testGame)
                }
            }
        }
    }
}

struct QuizListView_Previews: PreviewProvider {
    static var quizGames: [QuizGame] = [
        QuizGame(gameID: "1", name_p1: "Tom", name_p2: "Kevin"),
        QuizGame(gameID: "2", name_p1: "Tom", name_p2: "Thomas"),
        QuizGame(gameID: "3", name_p1: "Tom", name_p2: "Justus")
    ]
    static var previews: some View {
        QuizListView(quizGames: quizGames)
    }
}
