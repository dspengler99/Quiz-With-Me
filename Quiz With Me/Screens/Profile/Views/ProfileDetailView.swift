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
                .padding(.bottom, 30)
                Text("Anzahl der Spiele:")
                    .h2()
                    .foregroundColor(.darkBlue)
                Text("\(totalGames)")
                    .h1()
                    .foregroundColor(Color.gameRed)
                Divider()
                Text("Anzahl der erfolgreichen Spiele:")
                    .h2()
                    .foregroundColor(.darkBlue)
                Text("\(wonGames)")
                    .h1()
                    .foregroundColor(Color.gameGreen)
                Spacer()
            }
            .padding()
        }
    }
}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(name: "Test", email: "Test@email.de", totalGames: 5, wonGames: 1)
    }
}
