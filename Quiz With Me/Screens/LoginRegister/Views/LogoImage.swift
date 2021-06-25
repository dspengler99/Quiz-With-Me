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
            .frame(width: 200, height: 200, alignment: .top)
            .aspectRatio(contentMode: .fill)
    }
}

struct LogoImage_Previews: PreviewProvider {
    static var previews: some View {
        LogoImage()
    }
}
