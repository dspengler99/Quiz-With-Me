//
//  ProfileScreen.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 31.05.21.
//

import SwiftUI

struct ProfileScreen: View {
    @Binding var viewState: ViewState
    
    var body: some View {

         VStack(alignment: .leading) {
             ZStack {
                 Rectangle()
                     .frame(width: .infinity, height: 150, alignment: .top)
                     .foregroundColor(.blue)
                 VStack {
                     HStack {
                         Text("Max Mustermann")
                             .font(.title)
                         Spacer()
                     }
                     HStack {
                         Text("max@mustermann.de")
                         Spacer()
                     }
                 }
                 .padding()
             }
             AvatarImage()
             ProfileDetailView()
                 .padding(.top, 40)
             Spacer()
         }
         .edgesIgnoringSafeArea(.top)
     }
 }

 struct ProfileScreen_Previews: PreviewProvider {
     static var previews: some View {
        ProfileScreen(viewState: .constant(ViewState.PROFILE))
     }
 }
