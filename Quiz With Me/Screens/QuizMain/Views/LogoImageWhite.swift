//
//  LogoImageWhite.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 30.05.21.
//

import SwiftUI

struct LogoImageWhite: View {
     var body: some View {
         Image(decorative: "QuizWithMeQhite")
            .resizable()
            .padding()
            .frame(width: 120, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 20.0))
            .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.backgroundWhite, lineWidth: 5).shadow(radius: 3))
            .background(RoundedRectangle(cornerRadius: 20.0).fill(Color.white))
     }
 }

struct LogoImageWhite_Previews: PreviewProvider {
    static var previews: some View {
        LogoImageWhite()
    }
}
