//
//  GameOverviewScreen.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 22.05.21.
//

import SwiftUI

struct GameOverviewScreen: View {
    var game: Game
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.primaryBackground)
                        .frame(width: .infinity, height: 200)
                        .cornerRadius(25)
                    Text("Gegner xyz")
                        .frame(width: .infinity, height: 100, alignment: .top)
                        .foregroundColor(.white)
                        .font(Font.headline)
                }
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
            VStack {
                OverviewView()
                    .frame(width: 350, height: 550, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .offset(x: 0, y: 60)
                    .padding(.top, -60)
                    .cornerRadius(20)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                Button("Weiterspielen") {
                }
                .buttonStyle(PrimaryButton(width: 300, height: 50, fontSize: 15))
                .shadow(radius: 10)
            }
        }
    }
}

struct GameOverviewScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameOverviewScreen(game: Game(gameID: "1", userID_p1: "21", userID_p2: "22", username_p1: "Tester", username_p2: "Tester2", progress_p1: "2", progress_p2: "3", score_p1: "1", score_p2: "3"))
    }
}
