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
    @State var playerPoints: String = ""
    @State var rightAnswer = 0
    
    func checkPlayer(userName: String, nameP1: String) -> Bool {
        if(userName == nameP1) {
            return true
        }
        return false
    }
    
    func nextQuestion(selectedGame: String, playerProgress: String, progress: Int, gameQuestionIDs: [String]?) -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if(progress < gameQuestionIDs!.count-1) {
                DataManager.shared.incrementProgress(gameId: selectedGame, playerProgress: playerProgress)
                answerPicked = false
                self.progress = progress + 1
                _ = DataManager.shared.getQuestion(questionID: gameQuestionIDs![self.progress]).done { response in
                    if let newQuestion = response {
                        newQuestion.answers.shuffle()
                        self.question = newQuestion
                    }
                }
            } else {
                DataManager.shared.incrementProgress(gameId: selectedGame, playerProgress: playerProgress)
                viewState = .GAMEOVERVIEW
            }
        }
    }
    
    func getRightAnswerIndex(question: QuizQuestion?) -> Int {
        return (question?.answers.firstIndex(of: question!.rightAnswer))!
    }
    
    var body: some View {
        Group {
            EmptyView()
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
                    
                    Text("Frage \(progress + 1)/\(gameQuestionIds!.count)")
                        .padding(10)
                        .foregroundColor(Color.primaryButtonDefaultBackground)
                    
                    HStack {
                        Button(action: {
                            if(gameQuestion.checkAnswer(answer: gameQuestion.answers[0])) {
                                DataManager.shared.incrementPoints(gameId: selectedGame, playerPoints: playerPoints)
                            }
                            rightAnswer = getRightAnswerIndex(question: question)
                            answerPicked = true
                            nextQuestion(selectedGame: selectedGame, playerProgress: playerProgress, progress: progress, gameQuestionIDs: gameQuestionIds)
                        }) {
                            Text(gameQuestion.answers[0])
                                .frame(width: 150, height: 120)
                        }
                        .background(answerPicked ? (rightAnswer == 0 ? Color.green : Color.red) : Color.primaryButtonDefaultBackground)
                        .cornerRadius(25)
                        .shadow(radius: 20)
                        .padding(10)
                        .disabled(answerPicked)
                        
                        Button(action:  {
                            if(gameQuestion.checkAnswer(answer: gameQuestion.answers[1])) {
                                DataManager.shared.incrementPoints(gameId: selectedGame, playerPoints: playerPoints)
                            }
                            rightAnswer = getRightAnswerIndex(question: question)
                            answerPicked = true
                            nextQuestion(selectedGame: selectedGame, playerProgress: playerProgress, progress: progress, gameQuestionIDs: gameQuestionIds)
                        }) {
                            Text(gameQuestion.answers[1])
                                .frame(width: 150, height: 120)
                        }
                        .background(answerPicked ? (rightAnswer == 1 ? Color.green : Color.red) : Color.primaryButtonDefaultBackground)
                        .cornerRadius(25)
                        .shadow(radius: 20)
                        .padding(10)
                        .disabled(answerPicked)
                    }
                    
                    HStack {
                        Button(action: {
                            if(gameQuestion.checkAnswer(answer: gameQuestion.answers[2])) {
                                DataManager.shared.incrementPoints(gameId: selectedGame, playerPoints: playerPoints)
                            }
                            rightAnswer = getRightAnswerIndex(question: question)
                            answerPicked = true
                            nextQuestion(selectedGame: selectedGame, playerProgress: playerProgress, progress: progress, gameQuestionIDs: gameQuestionIds)
                        }) {
                            Text(gameQuestion.answers[2])
                                .frame(width: 150, height: 120)
                        }
                        .background(answerPicked ? (rightAnswer == 2 ? Color.green : Color.red) : Color.primaryButtonDefaultBackground)
                        .cornerRadius(25)
                        .shadow(radius: 20)
                        .padding(10)
                        .disabled(answerPicked)
                        
                        Button(action: {
                            if(gameQuestion.checkAnswer(answer: gameQuestion.answers[3])) {
                                DataManager.shared.incrementPoints(gameId: selectedGame, playerPoints: playerPoints)
                            }
                            rightAnswer = getRightAnswerIndex(question: question)
                            answerPicked = true
                            nextQuestion(selectedGame: selectedGame, playerProgress: playerProgress, progress: progress, gameQuestionIDs: gameQuestionIds)
                        }) {
                            Text(gameQuestion.answers[3])
                                .frame(width: 150, height: 120)
                        }
                        .background(answerPicked ? (rightAnswer == 3 ? Color.green : Color.red) : Color.primaryButtonDefaultBackground)
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
            _ = DataManager.shared.getGame(gameID: selectedGame).done { (response: (QuizGame?, String?)) in
                if response.0 == nil || response.1 == nil {
                    print("Es ist ein Fehler aufgetreten")
                }
                self.gameQuestionIds = response.0?.questionIDs
                if(checkPlayer(userName: quizUserWrapper.quizUser!.username, nameP1: response.0!.nameP1)) {
                    self.progress = response.0!.progressP1
                    self.playerProgress = "progressP1"
                    self.playerPoints = "pointsP1"
                } else {
                    self.progress = response.0!.progressP2
                    self.playerProgress = "progressP2"
                    self.playerPoints = "pointsP2"
                }
                _ = DataManager.shared.getQuestion(questionID: self.gameQuestionIds![self.progress]).done { response in
                    if let newQuestion = response {
                        newQuestion.answers.shuffle()
                        question = newQuestion
                    }
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
