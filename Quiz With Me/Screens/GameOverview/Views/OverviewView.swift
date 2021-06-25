//
//  OverviewView.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 31.05.21.
//

import SwiftUI

struct OverviewView: View {
    @EnvironmentObject var quizUserWrapper: QuizUserWrapper
    @Binding var viewState: ViewState
    @Binding var selectedGame: String
    @State private var game: QuizGame?
    
    private var isPlayer1: Bool {
        guard let quizUser = quizUserWrapper.quizUser, let quizGame = game else {
            fatalError("There should be a user to show this view.")
        }
        return quizUser.username == quizGame.nameP1
    }
    
    var body: some View {
        Group {
            EmptyView()
            if let quizGame = game, let _ = quizUserWrapper.quizUser {
                VStack {
                    HStack {
                        BackButton(viewState: $viewState, changeView: .HOME, color: .backgroundWhite)
                        Spacer()
                    }
                    .padding()
                    ZStack {
                        Color.backgroundWhite
                        VStack {
                            Text("Spielübersicht")
                                .h1_underline()
                                .foregroundColor(Color.darkBlue)
                                .padding(.bottom, 40)
                            Group {
                                HStack {
                                    Text("Du")
                                        .h2_underline()
                                        .foregroundColor(Color.gameGreen)
                                    Spacer()
                                }
                                .padding(.bottom, 10)
                                HStack {
                                    Text("Aktueller Fortschritt:")
                                        .h3()
                                        .foregroundColor(Color.darkBlue)
                                    Spacer()
                                    Text((isPlayer1 ? String(quizGame.progressP1) : String(quizGame.progressP2)) + "/\(quizGame.questionIDs.count)")
                                        .h3()
                                        .foregroundColor(Color.darkBlue)
                                }
                                .padding(.bottom, 5)
                                HStack {
                                    Text("Richtige Antworten:")
                                        .h3()
                                        .foregroundColor(Color.darkBlue)
                                    Spacer()
                                    Text((isPlayer1 ? String(quizGame.pointsP1) : String(quizGame.pointsP2)) + "/\(quizGame.questionIDs.count)")
                                        .h3()
                                        .foregroundColor(Color.darkBlue)
                                }
                                .padding(.bottom, 5)
                            }
                            Divider()
                                .frame(height: 3)
                                .foregroundColor(Color.accentYellow)
                            Group {
                                HStack {
                                    Text(isPlayer1 ? quizGame.nameP2 : quizGame.nameP1)
                                        .h2_underline()
                                        .foregroundColor(Color.gameRed)
                                    Spacer()
                                }
                                .padding(.bottom, 10)
                                HStack {
                                    Text("Aktueller Fortschritt:")
                                        .h3()
                                        .foregroundColor(Color.darkBlue)
                                    Spacer()
                                    Text("\(isPlayer1 ? String(quizGame.progressP2) : String(quizGame.progressP1))/\(quizGame.questionIDs.count)")
                                        .h3()
                                        .foregroundColor(Color.darkBlue)
                                }
                            }
                            Spacer()
                        }
                        .padding()
                    }
                    .frame(width: 350, height: 470)
                    .cornerRadius(25)
                    .shadow(radius: 20)
                    Spacer()
                    if (isPlayer1 && quizGame.progressP1 < quizGame.questionIDs.count) || (!isPlayer1 && quizGame.progressP2 < quizGame.questionIDs.count) {
                        Button(action: {
                            withAnimation {
                                viewState = .GAME
                            }
                        }) {
                            Text("Weiterspielen")
                                .h3()
                                .foregroundColor(Color.backgroundWhite)
                                .frame(width: 300, height: 50, alignment: .center)
                        }
                        .buttonStyle(PrimaryButton(width: 300, height: 50, fontSize: 15))
                        .padding(.bottom)
                        .shadow(radius: 20)
                    } else {
                        Text("Du hast alle Fragen beantwortet!")
                            .h3()
                            .foregroundColor(Color.primaryBlue)
                            .padding(.bottom)
                    }
                }
            } else {
                ProgressView()
            }
        }.onAppear {
            print(selectedGame)
            _ = DataManager.shared.getGame(gameID: selectedGame).done { (response: (QuizGame?, String?)) in
                if response.0 == nil || response.1 == nil {
                    print("Es ist ein Fehler aufgetreten")
                }
                self.game = response.0
            }
        }
    }
}

/*
 struct OverviewView_Previews: PreviewProvider {
 static var previews: some View {
 OverviewView(viewState: .constant(ViewState.HOME))
 }
 }
 */
