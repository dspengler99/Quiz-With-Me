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
    var totalGames: Int
    var wonGames: Int
    
     var body: some View {
         VStack(alignment: .leading) {
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
         }
         .padding()
     }
 }

 struct ProfileDetailView_Previews: PreviewProvider {
     static var previews: some View {
         ProfileDetailView(totalGames: 5, wonGames: 1)
     }
 }
