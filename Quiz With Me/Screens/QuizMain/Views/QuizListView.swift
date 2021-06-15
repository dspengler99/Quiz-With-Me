//
//  QuizListView.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 30.05.21.
//

import SwiftUI

struct QuizListView: View {
    @Binding var viewState: ViewState
    var quizGames: [String: QuizGame]
    @State private var gameObjects: [QuizGame] = []
    @State private var gameIDs: [String] = []
    
    func splitGameDict() {
        for (key, value) in quizGames {
            print("Appending!")
            gameObjects.append(value)
            gameIDs.append(key)
        }
    }

     var body: some View {
         ScrollView(.vertical) {
             VStack(spacing: 15) {
                if gameObjects.count >= 1 {
                    ForEach(0..<gameObjects.count) { index in QuizItemCard(viewState: $viewState, quizGame: gameObjects[index])
                     }
                }
             }
         }
         .onAppear {
            splitGameDict()
         }
     }
 }

 struct QuizListView_Previews: PreviewProvider {
     
     static var previews: some View {
        QuizListView(viewState: .constant(ViewState.HOME), quizGames: ["1": QuizGame(nameP1: "Daniel", nameP2: "Egzon")])
     }
 }
