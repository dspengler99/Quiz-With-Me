//
//  ProfileDetailView.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 31.05.21.
//

import SwiftUI

import SwiftUI

 struct ProfileDetailView: View {
     var body: some View {
         VStack(alignment: .leading) {
             Text("Anzahl der Spiele:")
                 .font(.title2)
             Text("5")
                 .foregroundColor(.red)
                 .font(.title)
             Divider()
             Text("Anzahl der erfolgreichen Spiele:")
                 .font(.title2)
             Text("1")
                 .foregroundColor(.green)
                 .font(.title)
         }
         .padding()
     }
 }

 struct ProfileDetailView_Previews: PreviewProvider {
     static var previews: some View {
         ProfileDetailView()
     }
 }
