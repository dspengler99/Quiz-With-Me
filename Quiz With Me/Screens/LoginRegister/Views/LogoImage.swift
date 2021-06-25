//
//  LogoImage.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 19.05.21.
//

import SwiftUI

/**
 This view shows the logo of the app and is used in the registration and login.
 */
struct LogoImage: View {
    var body: some View {
        Image(decorative: "QuizWithMeBlue")
            .resizable()
            .padding()
            .frame(width: 140, height: 140)
            .clipShape(RoundedRectangle(cornerRadius: 20.0))
            .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.backgroundWhite, lineWidth: 5).shadow(radius: 3))
            .background(RoundedRectangle(cornerRadius: 20.0).fill(Color.logoBlue))
    }
}

struct LogoImage_Previews: PreviewProvider {
    static var previews: some View {
        LogoImage()
    }
}
