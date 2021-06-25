//
//  QuizItemCard.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 30.05.21.
//

import SwiftUI

struct QuizItemCard: View {
    @EnvironmentObject var quizUserWrapper: QuizUserWrapper
    @Binding var viewState: ViewState
    @Binding var selectedGame: String
    
    private var isPlayer1: Bool {
        guard let quizUser = quizUserWrapper.quizUser else {
            fatalError("There should be a user to show this view.")
        }
        return quizUser.username == quizGame.nameP1
    }
    
    var quizGame: QuizGame
    var gameID: String
    
    var body: some View {
        ZStack {
            Color.primaryBlue
            VStack(alignment: .leading) {
                Text("Spiel mit \(isPlayer1 ? quizGame.nameP2 : quizGame.nameP1)")
                    .h1()
                    .foregroundColor(.accentYellow)
                Text("Beantwortete Fragen: \(isPlayer1 ? quizGame.progressP1 : quizGame.progressP2)/\(quizGame.questionIDs.count)")
                    .h2()
                    .foregroundColor(.accentYellow)
                Button(action: {
                    withAnimation {
                        selectedGame = gameID
                        viewState = .GAMEOVERVIEW
                    }
                }) {
                    Text("Zur Spielübersicht")
                        .h3()
                        .frame(width: 300, height: 50, alignment: .center)
                }
                .buttonStyle(PrimaryButton(width: 300, height: 50))
                .shadow(radius: 10)
                .padding()
            }
            .padding()
        }
        .frame(width: 350, height: 200)
        .cornerRadius(25)
        .shadow(radius: 7)
        .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))
    }
}

/*
 struct QuizItemView_Previews: PreviewProvider {
 static var testGame = QuizGame(nameP1: "Tom", nameP2: "Kevin")
 static var previews: some View {
 QuizItemCard(viewState: .constant(ViewState.HOME), quizGame: testGame, gameID: "1")
 }
 }
 */
