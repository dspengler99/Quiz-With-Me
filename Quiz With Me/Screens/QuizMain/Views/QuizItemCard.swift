//
//  QuizItemCard.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 30.05.21.
//

import SwiftUI

struct QuizItemCard: View {
     var quizGame: QuizGame

     var body: some View {
         ZStack {
             Color.blue
             VStack(alignment: .leading) {
                 Text("Spiel mit \(quizGame.nameP2)")
                     .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                 Text("Runde: \(quizGame.progressP1)")
                     .font(.title2)
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
     static var testGame = QuizGame(nameP1: "Tom", nameP2: "Kevin")
     static var previews: some View {
         QuizItemCard(quizGame: testGame)
     }
 }
