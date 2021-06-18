//
//  QuizMainScreen.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 30.05.21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import PromiseKit
struct QuizMainScreen: View {
    @EnvironmentObject var quizUserWrapper: QuizUserWrapper
    @State var menuToggeled = false
    @State private var games: [String: QuizGame]? = nil
    @Binding var viewState: ViewState
    @Binding var selectedGame: String
    
    var body: some View {
        Group {
            if let quizGames = games {
                VStack {
                    HStack(alignment: .top) {
                        Spacer()
                        LogoImageWhite()
                            .padding(.leading, 50)
                        Spacer()
                        MenuButton(menuToggled: $menuToggeled)
                    }
                    .padding()
                    QuizListView(viewState: $viewState, selectedgame: $selectedGame, quizGames: quizGames)
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.01), Color.white]), startPoint: .top, endPoint: .bottom)
                            .frame(width: .infinity, height: 50, alignment: .center)
                            .offset(x: 0, y: -58)
                        Color.white
                            .frame(width: .infinity, height: 50, alignment: .center)
                        Button("Neues Spiel") {
                        }
                        .buttonStyle(PrimaryButton(width: 300, height: 50, fontSize: 15))
                    }
                }
                .overlay(SideMenu(menuToggled: $menuToggeled))
                .onAppear {
                    print("Loaded \(quizGames.count) games")
                }
            } else {
                Text("Loading...")
            }
        }.onAppear {
            guard let quizUser = quizUserWrapper.quizUser else  {
                return
            }
            print(quizUser.gameIDs)
            DataManager.shared.getGames(gameIDs: quizUser.gameIDs).done { response in
                if let quizGames = response {
                    games = quizGames
                    print("Found \(quizGames.count) games")
                }
            }
        }
    }

}

/*
struct QuizMainScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuizMainScreen(viewState: .constant(ViewState.HOME))
    }
}
*/
