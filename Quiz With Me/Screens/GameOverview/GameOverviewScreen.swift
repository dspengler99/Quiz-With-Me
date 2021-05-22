//
//  GameOverviewScreen.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 22.05.21.
//

import SwiftUI

struct GameOverviewScreen: View {
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
        GameOverviewScreen()
    }
}
