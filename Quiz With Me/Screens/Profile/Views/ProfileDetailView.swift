//
//  ProfileDetailView.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 31.05.21.
//

import SwiftUI


/**
 This view renders all information that should be visible to the player. This information in general are statistics about the users played games.
 */
struct ProfileDetailView: View {
    var name: String
    var email: String
    var totalGames: Int
    var wonGames: Int
    var lostGames: Int
    
    var body: some View {
        ZStack {
            Color.backgroundWhite
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack {
                    Text(name)
                        .h1_bold()
                        .foregroundColor(.darkBlue)
                    Spacer()
                }
                HStack {
                    Text(email)
                        .h2_bold()
                        .foregroundColor(.darkBlue)
                    Spacer()
                }
                Divider()
                    .padding(5)
                Text("Anzahl der Spiele:")
                    .h2()
                    .foregroundColor(.darkBlue)
                Text("\(totalGames)")
                    .h2_bold()
                    .foregroundColor(Color.darkBlue)
                Text("Anzahl der gewonnenen Spiele:")
                    .h2()
                    .foregroundColor(.darkBlue)
                    .padding(.top, 5)
                Text("\(wonGames)")
                    .h2_bold()
                    .foregroundColor(Color.gameGreen)
                Text("Anzahl der verlorenen Spiele:")
                    .h2()
                    .foregroundColor(.darkBlue)
                    .padding(.top, 5)
                Text("\(lostGames)")
                    .h2_bold()
                    .foregroundColor(Color.gameRed)
                Spacer()
            }
            .padding()
        }
    }
}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(name: "Test", email: "Test@email.de", totalGames: 5, wonGames: 1, lostGames: 1)
    }
}
