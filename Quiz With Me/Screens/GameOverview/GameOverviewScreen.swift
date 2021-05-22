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
                Rectangle()
                    .fill(Color.primaryBackground)
                    .frame(width: .infinity, height: 200)
                    .cornerRadius(25)
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
            
            Spacer()
            
            OverviewView()
                .frame(width: 350, height: 550, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(20)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}

struct GameOverviewScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameOverviewScreen()
    }
}
