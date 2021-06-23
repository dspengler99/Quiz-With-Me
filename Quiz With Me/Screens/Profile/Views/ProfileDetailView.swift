//
//  ProfileDetailView.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 31.05.21.
//

import SwiftUI

 struct ProfileDetailView: View {
    var name: String
    var email: String
    var totalGames: Int
    var wonGames: Int
    
     var body: some View {
         VStack(alignment: .leading) {
            HStack {
                Text(name)
                    .font(.title)
                Spacer()
            }
            HStack {
                Text(email)
                    .font(.title2)
                Spacer()
            }
            .padding(.bottom, 30)
             Text("Anzahl der Spiele:")
                 .font(.title2)
             Text("\(totalGames)")
                 .foregroundColor(.red)
                 .font(.title)
             Divider()
             Text("Anzahl der erfolgreichen Spiele:")
                 .font(.title2)
             Text("\(wonGames)")
                 .foregroundColor(.green)
                 .font(.title)
            Spacer()
         }
         .padding()
     }
 }

 struct ProfileDetailView_Previews: PreviewProvider {
     static var previews: some View {
        ProfileDetailView(name: "Test", email: "Test@email.de", totalGames: 5, wonGames: 1)
     }
 }
