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

/**
 This screen shows the home screen of the app. It contains a list of all active games and the possibility to create new ones. An alert is shown when a game is finished.
 */
struct QuizMainScreen: View {
    @EnvironmentObject var quizUserWrapper: QuizUserWrapper
    @State var menuToggeled = false
    @State private var games: [String: QuizGame]? = nil
    @Binding var viewState: ViewState
    @Binding var selectedGame: String
    @State private var gameObjects: [QuizGame] = []
    @State private var gameIDs: [String] = []
    @State private var gameIndizes: [Int] = [] // Required for ForEach
    @State private var gameFinished = false
    @State private var finishedGameInformation: (String, Bool?, Int, Int) = ("Not set", nil, -1, -1)
    
    /**
     Searches the active games for a finished one. If a finished game is found it gets deleted from the user and the user will receive information.
     */
    func searchFinishedGame() -> Void {
        guard let quizUser = quizUserWrapper.quizUser else {
            fatalError("There should be a user loaded")
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
        // Reseting the game information, so no inconsistencies can appear.
        // This just happens, when no finished game is found.
        finishedGameInformation = ("Not set", nil, -1, -1)
        gameFinished = false
    }
    
    /**
     This method fills the gameInformation variable with the needed values and updates the statistics of the user.
     
     The variable `ownUserHasWon` will be `nil`, if a draw has occured (Both players had the same amount of points.
     
     - Parameter index: The index in `gameObjects` where the finished game was found.
     */
    func setFinishedGame(index: Int) -> Void {
        guard let quizUser = quizUserWrapper.quizUser else {
            fatalError("There should be loaded a user for this operation")
        }
        let othersUsername: String = quizUser.username == gameObjects[index].nameP1 ? gameObjects[index].nameP2 : gameObjects[index].nameP1
        var ownUserHasWon: Bool? = quizUser.username == gameObjects[index].nameP1 ? gameObjects[index].pointsP1 > gameObjects[index].pointsP2 : gameObjects[index].pointsP2 > gameObjects[index].pointsP1
        ownUserHasWon = gameObjects[index].pointsP1 == gameObjects[index].pointsP2 ? nil : ownUserHasWon
        let ownPoints: Int = quizUser.username == gameObjects[index].nameP1 ? gameObjects[index].pointsP1 : gameObjects[index].pointsP2
        let othersPoints: Int = quizUser.username == gameObjects[index].nameP1 ? gameObjects[index].pointsP2 : gameObjects[index].pointsP1
        DataManager.shared.updateStatistics(userID: quizUser.userID, hasWon: ownUserHasWon)
        finishedGameInformation = (othersUsername, ownUserHasWon, ownPoints, othersPoints)
    }
    
    /**
     This method constructs the message that will be shown in the alert when a game has finished.
     
     This job is not done by the alert itself, because it wouldn't be very readable.
     
     - returns: A String with the information message of the currently selected finished game.
     */
    func constructInformationMessage() -> String {
        guard let won = finishedGameInformation.1 else {
            return "Das Spiel gegen \(finishedGameInformation.0) ging unentschieden aus!"
        }
        return "Du hast das Spiel gegen \(finishedGameInformation.0) mit \(finishedGameInformation.2) zu \(finishedGameInformation.3) \(won ? "gewonnen" : "verloren")!"
    }
    
    /**
     Splits the dictionary with the game-IDs and coresponding games in two arrays. The entries are connected over their inde. That means that `gameObjects[index}` contains the game that belongs to `gameIDs[index]`. `index` is in both accesses the same value.
     
     After the splitting the arrays in the state of this view are refreshed.
     */
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
    }

    /**
     This method reloads the data and all needed information for the screen. It is called whenever the view is loaded or the button for a new game is clicked.
     */
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
        }
    }
    
    var body: some View {
        
        Group {
            EmptyView()
            if let _ = games, let _ = quizUserWrapper.quizUser{
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
                            // Check is necessary so no warning is thrown, when the user has no games.
                            if gameObjects.count >= 1 {
                                /**
                                 The array with the indezes is used here to render all games.
                                 
                                 It would have benn possible to shorten the code by just looping over the game-IDs array, but we found this just hard readable, because you would need a mix of accesses to an array and to a dictionary. Also values in a dictionary are all optionals, so another check would be necessary.
                                 */
                                ForEach(gameIndizes, id: \.self) { index in QuizItemCard(viewState: $viewState, selectedGame: $selectedGame, quizGame: gameObjects[index], gameID: gameIDs[index])
                                }
                            }
                        }
                    }
                    .onChange(of: quizUserWrapper.quizUser) { input in
                        print("Reloading")
                        reloadData()
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
                                    if let _ = response {
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
