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
    @State private var gameObjects: [QuizGame] = []
    @State private var gameIDs: [String] = []
    @State private var gameIndizes: [Int] = []
    @State private var gameFinished = false
    @State private var finishedGameInformation: (String, Bool?, Int, Int) = ("Not set", nil, -1, -1)
    
    func searchFinishedGame() -> Void {
        guard let quizUser = quizUserWrapper.quizUser else {
            fatalError("There should be a user loaded")
            return
        }
        for (index, game) in gameObjects.enumerated() {
            if game.progressP1 >= 10 && game.progressP2 >= 10 {
                setFinishedGame(index: index)
                DataManager.shared.deleteGameFromUser(userID: quizUser.userID, gameID: gameIDs[index]) {
                    gameFinished = true
                }
                return
            }
        }
        finishedGameInformation = ("Not set", nil, -1, -1)
        gameFinished = false
    }
    
    func setFinishedGame(index: Int) -> Void {
        guard let quizUser = quizUserWrapper.quizUser else {
            fatalError("There should be loaded a user for this operation")
            return
        }
        var othersUsername: String = quizUser.username == gameObjects[index].nameP1 ? gameObjects[index].nameP2 : gameObjects[index].nameP1
        var ownUserHasWon: Bool? = quizUser.username == gameObjects[index].nameP1 ? gameObjects[index].pointsP1 > gameObjects[index].pointsP2 : gameObjects[index].pointsP2 > gameObjects[index].pointsP1
        ownUserHasWon = gameObjects[index].pointsP1 == gameObjects[index].pointsP2 ? nil : ownUserHasWon
        var ownPoints: Int = quizUser.username == gameObjects[index].nameP1 ? gameObjects[index].pointsP1 : gameObjects[index].pointsP2
        var othersPoints: Int = quizUser.username == gameObjects[index].nameP1 ? gameObjects[index].pointsP2 : gameObjects[index].pointsP1
        DataManager.shared.updateStatistics(userID: quizUser.userID, hasWon: ownUserHasWon)
        finishedGameInformation = (othersUsername, ownUserHasWon, ownPoints, othersPoints)
    }
    
    func constructInformationMessage() -> String {
        guard let won = finishedGameInformation.1 else {
            return "Das Spiel gegen \(finishedGameInformation.0) ging unentschieden aus!"
        }
        return "Du hast das Spiel gegen \(finishedGameInformation.0) mit \(finishedGameInformation.2) zu \(finishedGameInformation.3) \(won ? "gewonnen" : "verloren")!"
    }
    
    func splitGameDict() {
        guard let quizGames = games else {
            return
        }
        var gameObjects: [QuizGame] = []
        var gameIDs: [String] = []
        for (key, value) in quizGames {
            gameObjects.append(value)
            gameIDs.append(key)
        }
        self.gameObjects = gameObjects
        self.gameIDs = gameIDs
        print("List has \(self.gameObjects.count) games")
        print("Dict has \(quizGames.count) values.")
    }

    func reloadData() -> Void {
        guard let oldQuizUser = quizUserWrapper.quizUser else  {
            return
        }
        _ = DataManager.shared.getUser(uid: oldQuizUser.userID).done {response in
            guard let newQuizUser = response else {
                return
            }
            quizUserWrapper.quizUser = newQuizUser
            if newQuizUser.gameIDs.count != 0 {
                _ = DataManager.shared.getGames(gameIDs: newQuizUser.gameIDs).done { response in
                    if let quizGames = response {
                        games = quizGames
                        splitGameDict()
                        gameIndizes = Array(0..<gameObjects.count)
                        if finishedGameInformation.2 == -1 && finishedGameInformation.3 == -1 {
                            self.searchFinishedGame()
                        }
                    }
                }
            } else {
                games = [:]
                splitGameDict()
                gameIndizes = []
            }
            print("User has \(newQuizUser.gameIDs.count) games")
        }
    }
    
    var body: some View {
        
        Group {
            if let quizGames = games, let quizUser = quizUserWrapper.quizUser{
                VStack {
                    HStack(alignment: .top) {
                        Spacer()
                        LogoImageWhite()
                            .padding(.leading, 50)
                        Spacer()
                        MenuButton(menuToggled: $menuToggeled)
                    }
                    .padding()
                    ScrollView(.vertical) {
                        VStack(spacing: 15) {
                            if gameObjects.count >= 1 {
                                ForEach(gameIndizes, id: \.self) { index in QuizItemCard(viewState: $viewState, selectedGame: $selectedGame, quizGame: gameObjects[index], gameID: gameIDs[index])
                                }
                            }
                        }
                    }
                    .alert(isPresented: $gameFinished) {
                        Alert(title: Text("Spiel beendet"), message: Text(constructInformationMessage()), dismissButton: .default(Text("Ok")) {
                            finishedGameInformation = ("Not set", nil, -1, -1)
                            reloadData()
                        })
                    }
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.01), Color.white]), startPoint: .top, endPoint: .bottom)
                            .frame(width: .infinity, height: 50, alignment: .center)
                            .offset(x: 0, y: -58)
                        Color.white
                            .frame(width: .infinity, height: 50, alignment: .center)
                        Button("Neues Spiel") {
                            do {
                                _ = try DataManager.shared.createNewGame().done { (response: (String, QuizGame)?) in
                                    if let returnedGame = response {
                                        self.reloadData()
                                    }
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                        .buttonStyle(PrimaryButton(width: 300, height: 50, fontSize: 15))
                    }
                }
                .overlay(SideMenu(menuToggled: $menuToggeled))
            } else {
                Text("Loading...")
            }
        }.onAppear {
            reloadData()
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
