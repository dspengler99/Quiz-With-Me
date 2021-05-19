//
//  LogoImage.swift
//  Quiz With Me
//
//  Created by Daniel Spengler on 19.05.21.
//

import SwiftUI

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
