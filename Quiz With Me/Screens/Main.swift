//
//  Main.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 30.05.21.
//

import SwiftUI

struct Main: View {
    @State var viewState: ViewState
    @State var selectedGame: String = ""
    
    var body: some View {
        switch(viewState) {
        case .LOGIN, .REGISTER:
            LoginRegisterScreen(viewState: $viewState)
        case .HOME:
            QuizMainScreen(viewState: $viewState, selectedGame: $selectedGame)
                .transition(.move(edge: .trailing))
        case .FRIENDSLIST:
            FriendsListScreen(viewState: $viewState)
        case .GAMEOVERVIEW:
            GameOverviewScreen(viewState: $viewState, selectedGame: $selectedGame)
        case .PROFILE:
            ProfileScreen(viewState: $viewState)
        case .GAME:
            QuestionScreen(viewState: $viewState, selectedGame: $selectedGame)
        }
    }
}

/*
struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main(viewState: ViewState.LOGIN)
    }
}
*/
