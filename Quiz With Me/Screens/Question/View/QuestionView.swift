//
//  QuestionView.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 03.06.21.
//

import SwiftUI

struct QuestionView: View {
    @State var progress = 0
    @State var answerPicked = false
    @Binding var viewState: ViewState
    @Binding var selectedGame: String
    @State var gameQuestionIds: [String]? = nil
    @State var question: QuizQuestion? = nil
    @EnvironmentObject var quizUserWrapper: QuizUserWrapper
    @State var playerProgress: String = ""
    
    func checkPlayer(userName: String, nameP1: String) -> Bool {
        if(userName == nameP1) {
            return true
        }
        return false
    }
    
    var body: some View {
        Group {
            if let gameQuestion = question {
                VStack {
                    HStack {
                        BackButton(viewState: $viewState, changeView: .HOME)
                        Spacer()
                    }
                    .padding()
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 350, height: 200)
                        .cornerRadius(25)
                        .shadow(radius: 20)
                        .overlay(Text(
                                    gameQuestion.question)
                                    .foregroundColor(.blue)
                                    .padding(40)
                                    .multilineTextAlignment(.center),
                                 alignment: .center)
                    
                    Text("Frage \(progress + 1)/10")
                        .padding(10)
                        .foregroundColor(Color.primaryButtonDefaultBackground)
                    
                    HStack {
                        Button(gameQuestion.answers[0]) {
                            answerPicked = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                if(progress < gameQuestionIds!.count-1) {
                                    progress += 1
                                    DataManager.shared.incrementProgress(gameId: selectedGame, playerProgress: playerProgress, progress: progress)
                                    answerPicked = false
                                    DataManager.shared.getQuestion(questionID: self.gameQuestionIds![self.progress]).done { response in
                                        question = response
                                    }
                                } else {
                                    progress += 1
                                    DataManager.shared.incrementProgress(gameId: selectedGame, playerProgress: playerProgress, progress: progress)
                                    print(progress)
                                    viewState = .GAMEOVERVIEW
                                }
                            }
                        }
                        .buttonStyle(QuestionButton(width: 150, height: 120, fontSize: 15))
                        .background(answerPicked ? (gameQuestion.checkAnswer(answer: gameQuestion.answers[0]) ? Color.green : Color.red) : Color.primaryButtonDefaultBackground)
                        .cornerRadius(25)
                        .shadow(radius: 20)
                        .padding(10)
                        .disabled(answerPicked)
                        
                        Button(gameQuestion.answers[1]) {
                            answerPicked = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                if(progress < gameQuestionIds!.count-1) {
                                    progress += 1
                                    DataManager.shared.incrementProgress(gameId: selectedGame, playerProgress: playerProgress, progress: progress)
                                    answerPicked = false
                                    DataManager.shared.getQuestion(questionID: self.gameQuestionIds![self.progress]).done { response in
                                        question = response
                                    }
                                } else {
                                    progress += 1
                                    DataManager.shared.incrementProgress(gameId: selectedGame, playerProgress: playerProgress, progress: progress)
                                    viewState = .GAMEOVERVIEW
                                }
                            }
                        }
                        .buttonStyle(QuestionButton(width: 150, height: 120, fontSize: 15))
                        .background(answerPicked ? (gameQuestion.checkAnswer(answer: gameQuestion.answers[1]) ? Color.green : Color.red) : Color.primaryButtonDefaultBackground)
                        .cornerRadius(25)
                        .shadow(radius: 20)
                        .padding(10)
                        .disabled(answerPicked)
                    }
                    
                    HStack {
                        Button(gameQuestion.answers[2]) {
                            answerPicked = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                if(progress < gameQuestionIds!.count-1) {
                                    progress += 1
                                    DataManager.shared.incrementProgress(gameId: selectedGame, playerProgress: playerProgress, progress: progress)
                                    answerPicked = false
                                    DataManager.shared.getQuestion(questionID: self.gameQuestionIds![self.progress]).done { response in
                                        question = response
                                    }
                                } else {
                                    progress += 1
                                    DataManager.shared.incrementProgress(gameId: selectedGame, playerProgress: playerProgress, progress: progress)
                                    viewState = .GAMEOVERVIEW
                                }
                            }
                        }
                        .buttonStyle(QuestionButton(width: 150, height: 120, fontSize: 15))
                        .background(answerPicked ? (gameQuestion.checkAnswer(answer: gameQuestion.answers[2]) ? Color.green : Color.red) : Color.primaryButtonDefaultBackground)
                        .cornerRadius(25)
                        .shadow(radius: 20)
                        .padding(10)
                        .disabled(answerPicked)
                        
                        Button(gameQuestion.answers[3]) {
                            answerPicked = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                if(progress < gameQuestionIds!.count-1) {
                                    progress += 1
                                    DataManager.shared.incrementProgress(gameId: selectedGame, playerProgress: playerProgress, progress: progress  )
                                    answerPicked = false
                                    DataManager.shared.getQuestion(questionID: self.gameQuestionIds![self.progress]).done { response in
                                        question = response
                                    }
                                } else {
                                    progress += 1
                                    DataManager.shared.incrementProgress(gameId: selectedGame, playerProgress: playerProgress, progress: progress)
                                    viewState = .GAMEOVERVIEW
                                }
                            }
                        }
                        .buttonStyle(QuestionButton(width: 150, height: 120, fontSize: 15))
                        .background(answerPicked ? (gameQuestion.checkAnswer(answer: gameQuestion.answers[3]) ? Color.green : Color.red) : Color.primaryButtonDefaultBackground)
                        .cornerRadius(25)
                        .shadow(radius: 20)
                        .padding(10)
                        .disabled(answerPicked)
                    }
                    Spacer()
                }
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            DataManager.shared.getGame(gameID: selectedGame).done { (response: (QuizGame?, String?)) in
                if response.0 == nil || response.1 == nil {
                    print("Es ist ein Fehler aufgetreten")
                }
                self.gameQuestionIds = response.0?.questionIDs
                if(checkPlayer(userName: quizUserWrapper.quizUser!.username, nameP1: response.0!.nameP1)) {
                    self.progress = Int(response.0!.progressP1)
                    self.playerProgress = "progressP1"
                } else {
                    self.progress = Int(response.0!.progressP2)
                    self.playerProgress = "progressP2"
                }
                DataManager.shared.getQuestion(questionID: self.gameQuestionIds![self.progress]).done { response in
                    question = response
                }
            }
        }
    }
}

/*
 struct QuestionView_Previews: PreviewProvider {
 static var previews: some View {
 QuestionView(viewState: .constant(ViewState.HOME))
 }
 }
 */
