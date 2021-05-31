//
//  QuizMainScreen.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 30.05.21.
//

import SwiftUI

struct QuizMainScreen: View {
    @State var menuToggeled = false
    var testGames: [QuizGame] = [
        QuizGame(gameID: "1", name_p1: "Tom", name_p2: "Kevin"),
        QuizGame(gameID: "2", name_p1: "Tom", name_p2: "Thomas"),
        QuizGame(gameID: "3", name_p1: "Tom", name_p2: "Justus")
    ]
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Spacer()
                LogoImageWhite()
                    .padding(.leading, 50)
                Spacer()
                MenuButton(menuToggled: $menuToggeled)
            }
            .padding()
            QuizListView(quizGames: testGames)
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
    }
}

struct QuizMainScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuizMainScreen()
    }
}
