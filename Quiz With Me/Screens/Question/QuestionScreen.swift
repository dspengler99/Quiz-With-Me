//
//  QuestionScreen.swift
//  Quiz With Me
//
//  Created by Egzon Jusufi on 03.06.21.
//

import SwiftUI

struct QuestionScreen: View {
    var body: some View {
        ZStack {
            BackgroundView()
            QuestionView()
        }
    }
}

struct QuestionScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuestionScreen()
    }
}
