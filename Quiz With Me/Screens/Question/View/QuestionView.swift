//
//  QuestionView.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 03.06.21.
//

import SwiftUI

/**
 This view represents the question and its answers. The background of the buttons is changed depending on the answer of the user.
 */
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
    
    /**
     Checks if the given user is equal to player 1 in a game.
     
     - Parameter userName: The username that should be checked against player 1
     - Parameter nameP1: The name of player 1 in the game.
     
     - returns: True if both given names are equal, false if not.
     */
    func checkPlayer(userName: String, nameP1: String) -> Bool {
        if(userName == nameP1) {
            return true
        }
        return false
    }
    
    /**
     Prepares the view for the next question and returns to the main screen when all questions are answered.
     
     - Parameter selectedGame: The id of the currently played game.
     - Parameter playerProgress: Is either `nameP1` or `nameP2`, depending on which player the user is in the game.
     - Parameter progress: The progress of the player.
     - Parameter gameQuestionIDs: The IDs of the questions belonging to the game.
     */
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
    
    /**
     This method returns the index of the right answer from the answers for the current question.
     
     Note that the return value can be unpacked explicitly, because we can be sure that the right answer needs to be included in all answers. If this is not the case, there has happened something wrong when questions were added to the Firebase.
     
     - Parameter question: The question of which we index of the right answer index should be determened.
     
     - returns: The index of the right answer for the given question.
     */
    func getRightAnswerIndex(question: QuizQuestion?) -> Int {
        return (question?.answers.firstIndex(of: question!.rightAnswer))!
    }
    
    var body: some View {
        Group {
            EmptyView()
            if let gameQuestion = question {
                VStack {
                    HStack {
                        BackButton(viewState: $viewState, changeView: .HOME, color: Color.accentYellow)
                        Spacer()
                    }
                    .padding()
                    Rectangle()
                        .fill(Color.backgroundWhite)
                        .frame(width: 350, height: 190)
                        .cornerRadius(25)
                        .shadow(radius: 20)
                        .overlay(Text(
                                    gameQuestion.question)
                                    .h3()
                                    .foregroundColor(.darkBlue)
                                    .padding(20)
                                    .multilineTextAlignment(.center),
                                 alignment: .center)
                    Text("Frage \(progress + 1)/\(gameQuestionIds!.count)")
                        .h3()
                        .padding(10)
                        .foregroundColor(Color.darkBlue)
                    
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
                                .h3()
                                .multilineTextAlignment(.center)
                                .frame(width: 140, height: 110)
                                .padding(10)
                                .foregroundColor(Color.backgroundWhite)
                        }
                        .background(answerPicked ? (rightAnswer == 0 ? Color.gameGreen : Color.gameRed) : Color.darkBlue)
                        .cornerRadius(25)
                        .shadow(radius: 10)
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
                                .h3()
                                .multilineTextAlignment(.center)
                                .frame(width: 140, height: 110)
                                .padding(10)
                                .foregroundColor(Color.backgroundWhite)
                        }
                        .background(answerPicked ? (rightAnswer == 1 ? Color.gameGreen : Color.gameRed) : Color.darkBlue)
                        .cornerRadius(25)
                        .shadow(radius: 10)
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
                                .h3()
                                .multilineTextAlignment(.center)
                                .frame(width: 140, height: 110)
                                .padding(10)
                                .foregroundColor(Color.backgroundWhite)
                        }
                        .background(answerPicked ? (rightAnswer == 2 ? Color.gameGreen : Color.gameRed) : Color.darkBlue)
                        .cornerRadius(25)
                        .shadow(radius: 10)
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
                                .h3()
                                .multilineTextAlignment(.center)
                                .frame(width: 140, height: 110)
                                .padding(10)
                                .foregroundColor(Color.backgroundWhite)
                        }
                        .background(answerPicked ? (rightAnswer == 3 ? Color.gameGreen : Color.gameRed) : Color.darkBlue)
                        .cornerRadius(25)
                        .shadow(radius: 10)
                        .padding(10)
                        .disabled(answerPicked)
                    }
                    Spacer()
                }
            } else {
                ProgressView("Lade…")
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.primaryBlue))
                    .foregroundColor(Color.darkBlue)
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


struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(viewState: .constant(ViewState.HOME), selectedGame: .constant("z2tmdhFW2vbRe9Qhxvrd"))
    }
}

