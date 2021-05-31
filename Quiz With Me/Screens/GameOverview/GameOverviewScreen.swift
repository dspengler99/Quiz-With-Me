//
//  GameOverviewScreen.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 31.05.21.
//

import SwiftUI

struct GameOverviewScreen: View {
    @Binding var viewState: ViewState
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.purple)
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
            
            Spacer()
            
            VStack {
                OverviewView()
                    .frame(width: 350, height: 550, alignment: .center)
                    .offset(x: 0, y: 10)
                    .padding(.top, -10)
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
        GameOverviewScreen(viewState: .constant(ViewState.GAMEOVERVIEW))
    }
}
