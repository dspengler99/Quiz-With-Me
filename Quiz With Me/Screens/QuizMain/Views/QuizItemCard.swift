//
//  QuizItemView.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 27.05.21.
//

import SwiftUI

struct QuizItemCard: View {
    var quizGame: QuizGame
    
    var body: some View {
        ZStack {
            Color.blue
            VStack(alignment: .leading) {
                Text("Spiel mit \(quizGame.name_p2)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("Runde: \(quizGame.progress_p1)")
                    .font(.title2)
                Text("Spielstart: \(quizGame.gameDate)")
                    .font(.subheadline)
                Button("Zur Spielübersicht") {
                }
                .buttonStyle(PrimaryButton(width: 300, height: 50, fontSize: 15))
                .padding()
            }
            .padding()
        }
        .frame(width: 350, height: 200)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

struct QuizItemView_Previews: PreviewProvider {
    static var testGame = QuizGame(gameID: "1", name_p1: "Tom", name_p2: "Kevin")
    static var previews: some View {
        QuizItemCard(quizGame: testGame)
    }
}
