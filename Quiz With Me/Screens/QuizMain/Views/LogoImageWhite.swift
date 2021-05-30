//
//  LogoImageWhite.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 27.05.21.
//

import SwiftUI

struct LogoImageWhite: View {
    var body: some View {
        Image(decorative: "QuizWithMeQhite")
            .resizable()
            .frame(width: 70, height: 70, alignment: .center)
    }
}

struct LogoImageWhite_Previews: PreviewProvider {
    static var previews: some View {
        LogoImageWhite()
    }
}
