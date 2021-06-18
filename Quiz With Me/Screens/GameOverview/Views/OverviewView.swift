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
            if let quizGame = game, let quizUser = quizUserWrapper.quizUser {
                VStack {
                    HStack {
                        BackButton(viewState: $viewState, changeView: .HOME)
                        Spacer()
                    }
                    Spacer()
                    ZStack {
                        Color.white
                            .ignoresSafeArea(edges: .all)
                        VStack {
                            Text("Spielübersicht")
                                .underline()
                                .font(.title)
                                .foregroundColor(Color.primaryButtonDefaultBackground)
                                .padding(.bottom, 40)
                            Group {
                                HStack {
                                    Text("Du")
                                        .underline()
                                        .foregroundColor(Color.primaryButtonDefaultBackground)
                                    Spacer()
                                }
                                .padding(.bottom, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                HStack {
                                    Text("Aktueller Fortschritt:")
                                    Spacer()
                                    Text((isPlayer1 ? String(quizGame.progressP1) : String(quizGame.progressP2)) + "/\(quizGame.questionIDs.count)")
                                }
                                .padding(.bottom, 5)
                                HStack {
                                    Text("Richtige Antworten:")
                                    Spacer()
                                    Text("2/10")
                                }
                                .padding(.bottom, 5)
                            }
                            Divider()
                            Group {
                                HStack {
                                    Text(isPlayer1 ? quizGame.nameP2 : quizGame.nameP1)
                                        .underline()
                                        .foregroundColor(Color.primaryButtonDefaultBackground)
                                    Spacer()
                                }
                                .padding(.bottom, 10)
                                HStack {
                                    Text("Aktueller Fortschritt:")
                                    Spacer()
                                    Text(isPlayer1 ? String(quizGame.progressP2) : String(quizGame.progressP1))
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
                        Button("Weiterspielen") {
                            withAnimation {
                                viewState = .GAME
                            }
                        }
                        .buttonStyle(PrimaryButton(width: 300, height: 50, fontSize: 15))
                        .shadow(radius: 20)
                    } else {
                        Text("Du hast alle Fragen beantwortet!")
                    }
                }
                .padding()
            } else {
                Text("Loading...")
            }
        }.onAppear {
            print(selectedGame)
            DataManager.shared.getGame(gameID: selectedGame).done { (response: (QuizGame?, String?)) in
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
